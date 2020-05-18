Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F781D72FE
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgERIca (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgERIc3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 04:32:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18EC05BD09
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 01:32:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w18so8960303ilm.13
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mvLAgECqlJWVhq8+1/O9VvCMUnBRGh8ISOkeMhSW+s=;
        b=pL7MAsa4t1SnK8s7l0bRUzZyh8rkVLmYmLLYhaNlyn15EvAV1kLg3GQ4adn/ZnRQny
         pSSmGNMKTkme3OK0O58NBKEPDCBBBRb9yJVsloZN36EF0WQLagpHB4iHzaIgLFF+VFav
         uYs56ixpPczsfO+UeWIUF/iQpMM1gWfQCKal0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mvLAgECqlJWVhq8+1/O9VvCMUnBRGh8ISOkeMhSW+s=;
        b=kDPq4Xv9TIPQ6S1A6huiuZDt1vYgxKOOjFa+alzfdvG1fxseie+lEqoxfFj974SxSa
         b689lz86fGVH3n15Sr+VTF+4gfACfNCupDejP43nLUjpYnqxIfbxLCm7MSduo/TiXTrE
         1Mfo9MCT64BsBVU/cLSTAemhtejF/fCntS+/RfK0pd3XkV55kcMUIkfK3KF/PT4/W/Je
         dyA/7dhI/UJhRtotAdrYSkfPsPoaZjrPGEfPK0fWqFJpbvS1lWWs+rkJ+yCzgWVWoYiD
         YsSrq0uMAn+a+eoJBdUysl835Y64hOVBkDzW7imbWBshmc6pYogmKRZNZGgHB8BZ7Oh1
         dTCA==
X-Gm-Message-State: AOAM530wiBx/ymW+1hWvQA6hBCfIpJiqH/Seplz4pkTv1K2GRNH34Pmx
        UGuJS6J18TpsO+IM00ozunkMvw==
X-Google-Smtp-Source: ABdhPJzND5S3JzjJSN3NfDQX+PGbBU7+gR0wbx28LlZP3UFCiXyU03/J8WmPLtROTZzY8ZeacbwvzQ==
X-Received: by 2002:a92:3c49:: with SMTP id j70mr8073984ila.286.1589790747478;
        Mon, 18 May 2020 01:32:27 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id d12sm4551792ill.80.2020.05.18.01.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 01:32:26 -0700 (PDT)
Date:   Mon, 18 May 2020 08:32:25 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200518083224.GA16270@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <202005171428.68F30AA0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005171428.68F30AA0@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 02:30:57PM -0700, Kees Cook wrote:
> On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> 
> I'm going read this thread more carefully tomorrow, but I just wanted to
> mention that I'd *like* to extend seccomp_data for doing deep argument
> inspection of the new syscalls. I think it's the least bad of many
> designs, and I'll write that up in more detail. (I would *really* like
> to avoid extending seccomp's BPF language, and instead allow probing
> into the struct copied from userspace, etc.)
> 
> Anyway, it's very related to this, so, yeah, probably we need a v2 of the
> notif API, but I'll try to get all the ideas here collected in one place.
I scratched together a proposal of what I think would make a not-terrible
V2 API. I'm sure there's bugs in this code, but I think it's workable --
or at least a place to start. The biggest thing I think we should consider
is unrolling seccomp_data if we don't intend to add new BPF-accessible
fields.

If also uses read(2), so we get to take advantage of read(2)'s ability
to pass a size along with the read, as opposed to doing ioctl tricks.
It also makes programming from against it slightly simpler. I can imagine
that the send API could be similar, in that it could support write, and
thus making it 100% usable from Go (and the like) without requiring
a separate OS-thread be spun up to interact with the listener.

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index c1735455bc53..db6e5335ec6a 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -113,6 +113,41 @@ struct seccomp_notif_resp {
 	__u32 flags;
 };
 
+#define SECCOMP_DATA_SIZE_VER0	64
+
+#define SECCOMP_NOTIF_CONFIG_SIZE_VER0	16
+
+/* Optional seccomp return fields */
+/* __u32 for triggering pid */
+#define SECCOMP_NOTIF_FIELD_PID		(1UL << 1)
+/* __u32 for triggering  thread group leader id */
+#define SECCOMP_NOTIF_FIELD_TGID	(1UL << 1)
+
+struct seccomp_notif_config {
+	__u32 size;
+	/*
+	 * The supported SECCOMP_DATA_SIZE to be returned. If the size passed in
+	 * is unsupported (seccomp_data is too small or if it is larger than the
+	 * currently supported size), EINVAL or E2BIG will be, respectively,
+	 * returned, and this will be set to the latest supported size.
+	 */
+	__u32 seccomp_data_size;
+	/*
+	 * This is an OR'd together list of SECCOMP_NOTIF_FIELD_*. If an
+	 * unsupported field is requested, ENOTSUPP will be returned.
+	 */
+	__u64 optional_fields;
+};
+
+/* read(2) Notification format example:
+ * struct seccomp_notif_read {
+ *	__u64 id;
+ *	__u32 pid; if SECCOMP_NOTIF_FIELD_PID
+ *	__u32 tgid; if SECCOMP_NOTIF_FIELD_TGID
+ *	struct seccomp_data data;
+ * };
+ */
+
 #define SECCOMP_IOC_MAGIC		'!'
 #define SECCOMP_IO(nr)			_IO(SECCOMP_IOC_MAGIC, nr)
 #define SECCOMP_IOR(nr, type)		_IOR(SECCOMP_IOC_MAGIC, nr, type)
@@ -124,4 +159,10 @@ struct seccomp_notif_resp {
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
 #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+/*
+ * Configure the data structure to be returned by read(2).
+ * Returns the size of the data structure which will be returned.
+ */
+#define SECCOMP_IOCTL_NOTIF_CONFIG	SECCOMP_IOR(3,	\
+						struct seccomp_notif_config)
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..4670cb03c390 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -95,12 +95,19 @@ struct seccomp_knotif {
  * @next_id: The id of the next request.
  * @notifications: A list of struct seccomp_knotif elements.
  * @wqh: A wait queue for poll.
+ * @read_size: The size of the expected read. If it is set to 0, it means that
+ *             reading notifications via read(2) is not yet configured. Until
+ *             then, EINVAL will be returned via read(2).
+ * @data_size: The supported size of seccomp_data.
+ * @optional_fields: The optional fields to return on read
  */
 struct notification {
 	struct semaphore request;
 	u64 next_id;
 	struct list_head notifications;
 	wait_queue_head_t wqh;
+	u32 read_size;
+	u64 optional_fields;
 };
 
 /**
@@ -1021,79 +1028,160 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long seccomp_notify_recv(struct seccomp_filter *filter,
-				void __user *buf)
+static void seccomp_reset_notif(struct seccomp_filter *filter,
+				u64 id)
 {
-	struct seccomp_knotif *knotif = NULL, *cur;
-	struct seccomp_notif unotif;
-	ssize_t ret;
-
-	/* Verify that we're not given garbage to keep struct extensible. */
-	ret = check_zeroed_user(buf, sizeof(unotif));
-	if (ret < 0)
-		return ret;
-	if (!ret)
-		return -EINVAL;
+	struct seccomp_knotif *cur;
 
-	memset(&unotif, 0, sizeof(unotif));
+	/*
+	 * Something went wrong. To make sure that we keep this
+	 * notification alive, let's reset it back to INIT. It
+	 * may have died when we released the lock, so we need to make
+	 * sure it's still around.
+	 */
+	mutex_lock(&filter->notify_lock);
+	list_for_each_entry(cur, &filter->notif->notifications, list) {
+		if (cur->id == id) {
+			cur->state = SECCOMP_NOTIFY_INIT;
+			up(&filter->notif->request);
+			break;
+		}
+	}
+	mutex_unlock(&filter->notify_lock);
+}
+/*
+ * Returns the next knotif available. If the return is a non-error, it will
+ * be with notify_lock held. It is up to the caller to unlock it.
+ */
+static struct seccomp_knotif *seccomp_get_notif(struct seccomp_filter *filter)
+{
+	struct seccomp_knotif *cur;
+	int ret;
 
 	ret = down_interruptible(&filter->notif->request);
 	if (ret < 0)
-		return ret;
+		return ERR_PTR(ret);
 
 	mutex_lock(&filter->notify_lock);
 	list_for_each_entry(cur, &filter->notif->notifications, list) {
 		if (cur->state == SECCOMP_NOTIFY_INIT) {
-			knotif = cur;
-			break;
+			cur->state = SECCOMP_NOTIFY_SENT;
+			wake_up_poll(&filter->notif->wqh,
+				     EPOLLOUT | EPOLLWRNORM);
+			return cur;
 		}
 	}
-
+	mutex_unlock(&filter->notify_lock);
 	/*
 	 * If we didn't find a notification, it could be that the task was
 	 * interrupted by a fatal signal between the time we were woken and
 	 * when we were able to acquire the rw lock.
 	 */
-	if (!knotif) {
-		ret = -ENOENT;
-		goto out;
-	}
+	return ERR_PTR(-ENOENT);
+}
+
+static long seccomp_notify_recv(struct seccomp_filter *filter,
+				void __user *buf)
+{
+	struct seccomp_knotif *knotif;
+	struct seccomp_notif unotif;
+	ssize_t ret;
+
+	/* Verify that we're not given garbage to keep struct extensible. */
+	ret = check_zeroed_user(buf, sizeof(unotif));
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EINVAL;
+
+	memset(&unotif, 0, sizeof(unotif));
+
+	knotif = seccomp_get_notif(filter);
+	if (IS_ERR(knotif))
+		return PTR_ERR(knotif);
 
 	unotif.id = knotif->id;
 	unotif.pid = task_pid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
 
-	knotif->state = SECCOMP_NOTIFY_SENT;
-	wake_up_poll(&filter->notif->wqh, EPOLLOUT | EPOLLWRNORM);
-	ret = 0;
-out:
 	mutex_unlock(&filter->notify_lock);
 
-	if (ret == 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
-		ret = -EFAULT;
+	if (!copy_to_user(buf, &unotif, sizeof(unotif)))
+		return 0;
 
-		/*
-		 * Userspace screwed up. To make sure that we keep this
-		 * notification alive, let's reset it back to INIT. It
-		 * may have died when we released the lock, so we need to make
-		 * sure it's still around.
-		 */
-		knotif = NULL;
-		mutex_lock(&filter->notify_lock);
-		list_for_each_entry(cur, &filter->notif->notifications, list) {
-			if (cur->id == unotif.id) {
-				knotif = cur;
-				break;
-			}
-		}
+	seccomp_reset_notif(filter, unotif.id);
+	return -EFAULT;
+}
 
-		if (knotif) {
-			knotif->state = SECCOMP_NOTIFY_INIT;
-			up(&filter->notif->request);
-		}
-		mutex_unlock(&filter->notify_lock);
+/* Append the src value to the dst, and return the new cursor */
+#define append(dst, src)	({		\
+	typeof(src) _src = src;			\
+	memcpy(dst, &_src, sizeof(_src));	\
+	dst + sizeof(_src);			\
+})
+
+/*
+ * Append the value pointer to by the pointer, src, to the dst
+ * and return the new cursor
+ */
+#define append_ptr(dst, src)	({		\
+	typeof(src) _src = src;			\
+	memcpy(dst, _src, sizeof(*_src));	\
+	dst + sizeof(*_src);			\
+})
+
+static ssize_t seccomp_notify_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct seccomp_filter *filter = file->private_data;
+	u32 optional_fields, read_size;
+	struct seccomp_knotif *knotif;
+	void *kbuf, *cursor;
+	int ret;
+	u64 id;
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret)
+		return ret;
+	read_size = filter->notif->read_size;
+	optional_fields = filter->notif->optional_fields;
+	mutex_unlock(&filter->notify_lock);
+
+	if (read_size == 0)
+		return -EINVAL;
+	if (count < read_size)
+		return -ENOSPC;
+
+	knotif = seccomp_get_notif(filter);
+	if (IS_ERR(knotif))
+		return PTR_ERR(knotif);
+
+	id = knotif->id;
+	kbuf = kzalloc(read_size, GFP_KERNEL);
+	if (!kbuf) {
+		ret = -ENOMEM;
+		goto out;
 	}
 
+	cursor = kbuf;
+	cursor = append(cursor, knotif->id);
+	if (filter->notif->optional_fields & SECCOMP_NOTIF_FIELD_PID)
+		cursor = append(cursor, task_pid_vnr(knotif->task));
+	if (filter->notif->optional_fields & SECCOMP_NOTIF_FIELD_TGID)
+		cursor = append(cursor, task_tgid_vnr(knotif->task));
+	cursor = append_ptr(cursor, knotif->data);
+	WARN_ON_ONCE(cursor != kbuf + read_size);
+
+	ret = copy_to_user(buf, kbuf, read_size);
+	if (!ret)
+		ret = read_size;
+
+	kfree(kbuf);
+out:
+	mutex_unlock(&filter->notify_lock);
+	if (ret < 0)
+		seccomp_reset_notif(filter, id);
+
 	return ret;
 }
 
@@ -1175,6 +1263,70 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	return ret;
 }
 
+static long seccomp_notif_config(struct seccomp_filter *filter,
+				 struct seccomp_notif_config __user *uconfig)
+{
+	struct seccomp_notif_config config;
+	/* ret_size is a minimum of 8, given id */
+	int ret, notification_size = 8;
+	u32 size;
+
+
+	ret = get_user(size, &uconfig->size);
+	if (ret)
+		return ret;
+	ret = copy_struct_from_user(&config, sizeof(config), uconfig, size);
+	if (ret)
+		return ret;
+
+	/*
+	 * This needs to be bumped every time we change seccomp_data's size
+	 */
+	BUILD_BUG_ON(sizeof(struct seccomp_data) != SECCOMP_DATA_SIZE_VER0);
+	if (config.seccomp_data_size < SECCOMP_DATA_SIZE_VER0) {
+		ret = -EINVAL;
+		goto invalid_seccomp_data_size;
+	}
+	if (config.seccomp_data_size > SECCOMP_DATA_SIZE_VER0) {
+		ret = -E2BIG;
+		goto invalid_seccomp_data_size;
+	}
+	notification_size += config.seccomp_data_size;
+
+	if (config.optional_fields & ~(SECCOMP_NOTIF_FIELD_PID|SECCOMP_NOTIF_FIELD_TGID))
+		return -ENOTSUPP;
+
+	if (config.optional_fields & SECCOMP_NOTIF_FIELD_PID)
+		notification_size += 4;
+	if (config.optional_fields & SECCOMP_NOTIF_FIELD_TGID)
+		notification_size += 4;
+
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		return ret;
+
+	if (filter->notif->read_size) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = notification_size;
+	filter->notif->read_size = notification_size;
+	filter->notif->optional_fields = config.optional_fields;
+
+out:
+	mutex_unlock(&filter->notify_lock);
+
+	return ret;
+
+invalid_seccomp_data_size:
+	if (put_user(SECCOMP_DATA_SIZE_VER0, &uconfig->seccomp_data_size))
+		return -EFAULT;
+
+	return ret;
+}
+
 static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1188,6 +1340,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 		return seccomp_notify_send(filter, buf);
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_CONFIG:
+		return seccomp_notif_config(filter, buf);
 	default:
 		return -EINVAL;
 	}
@@ -1224,6 +1378,7 @@ static const struct file_operations seccomp_notify_ops = {
 	.release = seccomp_notify_release,
 	.unlocked_ioctl = seccomp_notify_ioctl,
 	.compat_ioctl = seccomp_notify_ioctl,
+	.read = seccomp_notify_read,
 };
 
 static struct file *init_listener(struct seccomp_filter *filter)


> 
> -- 
> Kees Cook
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
