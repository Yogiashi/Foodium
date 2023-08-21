class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # チェックボックスから送られてきたタグidを受け取る
    old_tag_ids = params[:post][:tag_ids]
    # 受け取った値から空白のものを取り除く
    old_tag_ids.delete('')
    # 受け取ったタグidからタグの名前を取得
    old_tags = Tag.find(old_tag_ids).pluck('name')
    # 新規で入力されたタグを受け取る
    new_tags = params[:post][:name].split(',')
    # チェックボックスから選択されたタグと新規で入力されたタグを足す
    tag_list = new_tags + old_tags
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path, notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def index
    # 公開中の投稿を取得
    @posts = Post.all.where(displayed: true).page(params[:posts_page]).per(12).order(created_at: :desc)
    # フォローしてるユーザーの公開中の投稿を取得
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: true).page(params[:following_page]).per(12).order(created_at: :desc)
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    # チェックボックスから送られてきたタグidを受け取る
    old_tag_ids = params[:post][:tag_ids]
    # 受け取った値から空白のものを取り除く
    old_tag_ids.delete('')
    # 受け取ったタグidからタグの名前を取得
    old_tags = Tag.find(old_tag_ids).pluck('name')
    # 新規で入力されたタグを受け取る
    new_tags = params[:post][:name].split(',')
    # チェックボックスから選択されたタグと新規で入力されたタグを足す
    tag_list = new_tags + old_tags
    if @post.update(post_params)
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
    @posts = @tag.posts.where(displayed: true).page(params[:page]).per(12).order(created_at: :desc)
  end

  def search
    # 検索フォームから送られた値を受け取り公開中の投稿を取得
    @posts = Post.search(params[:word]).where(displayed: :true).page(params[:page]).per(12).order(created_at: :desc)
    # 価格検索フォームから送られた値があれば受け取り検索
    @posts = @posts.price_search(params[:min_search], params[:max_search]).page(params[:page]).per(12).order(created_at: :desc) if params[:min_search].present? or  params[:max_search].present?
    @tag_ids = params[:tag_ids]&.select(&:present?)
    if @tag_ids.present?
      @tag_word = " "
      @tag_ids.each do |id|
        @tag_word = @tag_word + " " + '"' + Tag.find(id).name + '"'  if id != ""
      end
      # タグチェックボックスから送られた値があれば受け取り検索
      @posts = @posts.joins(:post_tags).where(post_tags: {tag_id: @tag_ids}).group("posts.id").having("count(*) = #{@tag_ids.length}").page(params[:page]).per(12).order(created_at: :desc)
    end
  end

  private
  def post_params
    params.require(:post).permit({post_images: []}, :shop_name, :dish_name, :caption, :price, :address, :latitude, :longitude, :tag, :displayed)
  end
  
  # urlから直接アクセスされるのを防ぐ
  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end
end
