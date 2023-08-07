class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    old_tag = params[:post][:old_name].split(',')
    new_tag = params[:post][:name].split(',')
    tag_list = new_tag + old_tag
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path, notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    # フォローしてるユーザーの投稿を取得
    @following_posts = Post.where(user_id: [*current_user.following_ids])
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list=@post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @old_relations = PostTag.where(post_id: @post.id)
      # それらを取り出し、消す。消し終わる
       @old_relations.each do |relation|
      relation.delete
      end
      @post.save_tag(tag_list)
      redirect_to post_path(@post), notice: "投稿内容を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.user), notice: "投稿を削除しました。"
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts = @tag.posts
  end

  def search
    @posts = Post.search(params[:word])
  end

  private
  def post_params
    params.require(:post).permit(:post_image, :shop_name, :dish_name, :caption, :price, :address, :latitude, :longitude, :tag)
  end
end
