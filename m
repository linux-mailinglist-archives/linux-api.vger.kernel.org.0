Return-Path: <linux-api+bounces-6470-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H3VDG6JG2rMDwkAu9opvQ
	(envelope-from <linux-api+bounces-6470-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:05:50 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1D61416E
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62ABA306550E
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 01:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F827BF93;
	Sun, 31 May 2026 01:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+BLq0J2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943571A6830
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189366; cv=none; b=mwofpJ7iHTmz00PftnWd3XAjB9GvIp6w/Hvfff8CYBYRpYGewmbn9e0YnLxvPT/0nXD05F5+OT5cLBgOhMm2ofquN/sxCzswO7+ya6PdODhPnQKsp1sogq8Nvj9crepC588Cz+9EV+z3Yd1pGH30uPe5NfdnvnbHtkQOFW2Wpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189366; c=relaxed/simple;
	bh=vUJD/5u6kCUr8KTYSWHaD9vjocEHmK/li6avZTPmLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogcBI4jEN1u07MlrHyp/gbitlpBUBqDyj20V/K8sJ0P+BwI1hTUaPqt9wQVBQOieMQUrkZvD3jWOmpuPUDbm1ZbCn/QXJUE2hzrEJ0+WFR/MxRu/j4sR3+hvC/bMeDSD5accq8S/HjGXeemO0RKh3KYBJJnDPnemFX8GM2lVOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+BLq0J2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso1432885e9.3
        for <linux-api@vger.kernel.org>; Sat, 30 May 2026 18:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189363; x=1780794163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY9xqu8l7Va76QXZ+E4mFY8QOJNQ9i1JD1YVgseayQc=;
        b=R+BLq0J2w381bFRKFyzrU+hqNJJPVTY7d7VsekKBtYm2lA7bJQVZe3AMJE5yVJ9/it
         g50g4EL1SB1WnQCwPCqL87AoXk9JMoCEgo972LohIYWq60LxoyRwzJjr254rTvgyq+Xs
         PNxDwU6GjN0nm1jwAIr4s+IIFTW1zmDeJ9U/5yqC9KFx4IufSiPRpLmwbrKPgmULiNGf
         RjnVXDNGaHi3pNBD/2GW6RadBuI7zlRy1zn8XjbIqP6y2xrDYKiMms5F4+iBWXlMAjtW
         DtrP5KV2Oq9PPjiZX4wD0ViM1Z+usKZ+vFk0Nkjjk9jCqY14VKN47Vhb2U2cGARs62Fj
         3CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189363; x=1780794163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rY9xqu8l7Va76QXZ+E4mFY8QOJNQ9i1JD1YVgseayQc=;
        b=Lv9d8zKLoj7jhDQpVaHJ1qYk4vCjVUKZw2T4RIwPM8qia7et7g1/WDcIhJldn4tttE
         xMmy/gChiy0ftS10MwbbDz6y34ZxfA04qqPAnVFhKCJdcKfOrlN1eWKoDL+aBl4tFtxj
         OQctkHvC0YMVG9jmihP56WcqQB9n8p1GlU/vv13CIsriQe520QfSz0x/ce6zycYPRsnk
         idcGKCwjwVTaJUOG5tLzCVACjxB+Er8ABbjyjMYsZnhfiUS2eC3VZG0qQOFQoJpXee9a
         FqBX5kQUTAMXlLF75SjC/xVovNwwTvD+8Phfon8LK1tdmJ+G6x6L7O7N6N4cn7Z7aL5O
         ZVRg==
X-Forwarded-Encrypted: i=1; AFNElJ9kmEE3vTkU1Se+PmHCA93hkEaz/nv9AaZ0jLNNDs89crz6u/z3kMV9byEenBCUAvv669+ymXXIrPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nTgSPvD/Xa0LyxnAQurlkgg+vNWMJW2HHkbr4G7npI2Xtdpj
	PA80FirZke8yb4kgwp1J9BWWr4XdmFZfTkpgUgkvx4OUWm2U9sS55gf6
X-Gm-Gg: Acq92OGA/JFAZEyfU3iHg5GBcWIllru/JzBVwgPP2WxwQEbF49+5ROzd7C1f6KNWXsD
	LcWXYon7TTPr0+4gGNt2zI++5OS7TIykb0rZHwXPG7Q/SvOCEgg0tp4JkA9C/NRkU1nJbpRX0M/
	IWbvpjKO3KNwOY7II5PuBS6Qay5I6Z3WJO6R0Ls+0ZR5IBzmoNwNOuD/UOhYQrPK62ZzdYkqQbR
	Td08B+wj91oEC4NuHeB76V/nX5d2nLtGDLOJUYzqlp+YifPAtxg5Jd2e0PPjAieH16cxOequ8xt
	tQSdlE/l1tuLxQXvYcMq7Pz8blhI26qrpnbbFKixTC+5M7q2+K3eERAS9rOcuiTVwCu9kRrXvgk
	DxxAKy/ldRlhXnJ+42gL30RBDowAAy7yxUdlxXxNsahVx0ovQaZy/PN1TwaEAdkxsEB1ELXkxmv
	O6yjeZz+LAPRUQY5NBv/xlTDdwJdGO23dAhLV9Oto5
X-Received: by 2002:a05:600d:844a:10b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-490a294935bmr71684235e9.22.1780189362730;
        Sat, 30 May 2026 18:02:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909d68a925sm219356085e9.2.2026.05.30.18.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:02:42 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Sun, 31 May 2026 01:01:06 +0000
Message-ID: <20260531010107.1953702-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6470-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B8F1D61416E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmsplice behavior on writable pipe became equivalent to pwritev2.
vmsplice behavior on readable pipe already was nearly
equivalent to preadv2, but I made this explicit. I. e. I made it
obvious from code that vmsplice now is equivalent to preadv2/pwritev2.

Also I moved vmsplice to fs/read_write.c, because now it arguably
belongs there.

Note that SPLICE_F_NONBLOCK behavior slightly changed: previously
vmsplice ignored whether the pipe was opened with O_NONBLOCK, and mode
of operation depended on whether SPLICE_F_NONBLOCK was passed only.
Now the operation will be non-blocking if O_NONBLOCK was passed when
opening *or* SPLICE_F_NONBLOCK was passed to vmsplice. Previous
behavior was arguably buggy, and new behavior is arguably better.

Now SPLICE_F_GIFT is always ignored by all 3 syscalls: splice, tee
and vmsplice.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c          |  23 +++++
 fs/splice.c              | 192 +--------------------------------------
 include/linux/skbuff.h   |   4 +-
 include/linux/splice.h   |   2 +-
 include/linux/syscalls.h |   4 +-
 5 files changed, 29 insertions(+), 196 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 50bff7edc91f..1e5444f4dab3 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1213,6 +1213,29 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 	return do_pwritev(fd, vec, vlen, pos, flags);
 }
 
+/*
+ * Legacy preadv2/pwritev2 wrapper.
+ */
+SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
+		unsigned long, vlen, unsigned int, flags)
+{
+	if (unlikely(flags & ~SPLICE_F_ALL))
+		return -EINVAL;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	/* We do do_writev/do_readv, so it is okay to pass "false" here */
+	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+		return -EBADF;
+
+	if (fd_file(f)->f_mode & FMODE_WRITE)
+		return do_writev(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+	else
+		return do_readv(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+}
+
 /*
  * Various compat syscalls.  Note that they all pretend to take a native
  * iovec - import_iovec will properly treat those as compat_iovecs based on
diff --git a/fs/splice.c b/fs/splice.c
index 59adbc2fa4d6..b1a4e3713bd6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -159,22 +159,6 @@ const struct pipe_buf_operations page_cache_pipe_buf_ops = {
 	.get		= generic_pipe_buf_get,
 };
 
-static bool user_page_pipe_buf_try_steal(struct pipe_inode_info *pipe,
-		struct pipe_buffer *buf)
-{
-	if (!(buf->flags & PIPE_BUF_FLAG_GIFT))
-		return false;
-
-	buf->flags |= PIPE_BUF_FLAG_LRU;
-	return generic_pipe_buf_try_steal(pipe, buf);
-}
-
-static const struct pipe_buf_operations user_page_pipe_buf_ops = {
-	.release	= page_cache_pipe_buf_release,
-	.try_steal	= user_page_pipe_buf_try_steal,
-	.get		= generic_pipe_buf_get,
-};
-
 static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
@@ -589,8 +573,7 @@ static void splice_from_pipe_end(struct pipe_inode_info *pipe, struct splice_des
  * Description:
  *    This function does little more than loop over the pipe and call
  *    @actor to do the actual moving of a single struct pipe_buffer to
- *    the desired destination. See pipe_to_file, pipe_to_sendmsg, or
- *    pipe_to_user.
+ *    the desired destination. See pipe_to_file or pipe_to_sendmsg.
  *
  */
 ssize_t __splice_from_pipe(struct pipe_inode_info *pipe, struct splice_desc *sd,
@@ -1440,179 +1423,6 @@ static ssize_t __do_splice(struct file *in, loff_t __user *off_in,
 	return ret;
 }
 
-static ssize_t iter_to_pipe(struct iov_iter *from,
-			    struct pipe_inode_info *pipe,
-			    unsigned int flags)
-{
-	struct pipe_buffer buf = {
-		.ops = &user_page_pipe_buf_ops,
-		.flags = flags
-	};
-	size_t total = 0;
-	ssize_t ret = 0;
-
-	while (iov_iter_count(from)) {
-		struct page *pages[16];
-		ssize_t left;
-		size_t start;
-		int i, n;
-
-		left = iov_iter_get_pages2(from, pages, ~0UL, 16, &start);
-		if (left <= 0) {
-			ret = left;
-			break;
-		}
-
-		n = DIV_ROUND_UP(left + start, PAGE_SIZE);
-		for (i = 0; i < n; i++) {
-			int size = umin(left, PAGE_SIZE - start);
-
-			buf.page = pages[i];
-			buf.offset = start;
-			buf.len = size;
-			ret = add_to_pipe(pipe, &buf);
-			if (unlikely(ret < 0)) {
-				iov_iter_revert(from, left);
-				// this one got dropped by add_to_pipe()
-				while (++i < n)
-					put_page(pages[i]);
-				goto out;
-			}
-			total += ret;
-			left -= size;
-			start = 0;
-		}
-	}
-out:
-	return total ? total : ret;
-}
-
-static int pipe_to_user(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
-			struct splice_desc *sd)
-{
-	int n = copy_page_to_iter(buf->page, buf->offset, sd->len, sd->u.data);
-	return n == sd->len ? n : -EFAULT;
-}
-
-/*
- * For lack of a better implementation, implement vmsplice() to userspace
- * as a simple copy of the pipe's pages to the user iov.
- */
-static ssize_t vmsplice_to_user(struct file *file, struct iov_iter *iter,
-				unsigned int flags)
-{
-	struct pipe_inode_info *pipe = get_pipe_info(file, true);
-	struct splice_desc sd = {
-		.total_len = iov_iter_count(iter),
-		.flags = flags,
-		.u.data = iter
-	};
-	ssize_t ret = 0;
-
-	if (!pipe)
-		return -EBADF;
-
-	pipe_clear_nowait(file);
-
-	if (sd.total_len) {
-		pipe_lock(pipe);
-		ret = __splice_from_pipe(pipe, &sd, pipe_to_user);
-		pipe_unlock(pipe);
-	}
-
-	if (ret > 0)
-		fsnotify_access(file);
-
-	return ret;
-}
-
-/*
- * vmsplice splices a user address range into a pipe. It can be thought of
- * as splice-from-memory, where the regular splice is splice-from-file (or
- * to file). In both cases the output is a pipe, naturally.
- */
-static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
-				unsigned int flags)
-{
-	struct pipe_inode_info *pipe;
-	ssize_t ret = 0;
-	unsigned buf_flag = 0;
-
-	if (flags & SPLICE_F_GIFT)
-		buf_flag = PIPE_BUF_FLAG_GIFT;
-
-	pipe = get_pipe_info(file, true);
-	if (!pipe)
-		return -EBADF;
-
-	pipe_clear_nowait(file);
-
-	pipe_lock(pipe);
-	ret = wait_for_space(pipe, flags);
-	if (!ret)
-		ret = iter_to_pipe(iter, pipe, buf_flag);
-	pipe_unlock(pipe);
-	if (ret > 0) {
-		wakeup_pipe_readers(pipe);
-		fsnotify_modify(file);
-	}
-	return ret;
-}
-
-/*
- * Note that vmsplice only really supports true splicing _from_ user memory
- * to a pipe, not the other way around. Splicing from user memory is a simple
- * operation that can be supported without any funky alignment restrictions
- * or nasty vm tricks. We simply map in the user memory and fill them into
- * a pipe. The reverse isn't quite as easy, though. There are two possible
- * solutions for that:
- *
- *	- memcpy() the data internally, at which point we might as well just
- *	  do a regular read() on the buffer anyway.
- *	- Lots of nasty vm tricks, that are neither fast nor flexible (it
- *	  has restriction limitations on both ends of the pipe).
- *
- * Currently we punt and implement it as a normal copy, see pipe_to_user().
- *
- */
-SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
-		unsigned long, nr_segs, unsigned int, flags)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
-	struct iov_iter iter;
-	ssize_t error;
-	int type;
-
-	if (unlikely(flags & ~SPLICE_F_ALL))
-		return -EINVAL;
-
-	CLASS(fd, f)(fd);
-	if (fd_empty(f))
-		return -EBADF;
-	if (fd_file(f)->f_mode & FMODE_WRITE)
-		type = ITER_SOURCE;
-	else if (fd_file(f)->f_mode & FMODE_READ)
-		type = ITER_DEST;
-	else
-		return -EBADF;
-
-	error = import_iovec(type, uiov, nr_segs,
-			     ARRAY_SIZE(iovstack), &iov, &iter);
-	if (error < 0)
-		return error;
-
-	if (!iov_iter_count(&iter))
-		error = 0;
-	else if (type == ITER_SOURCE)
-		error = vmsplice_to_pipe(fd_file(f), &iter, flags);
-	else
-		error = vmsplice_to_user(fd_file(f), &iter, flags);
-
-	kfree(iov);
-	return error;
-}
-
 SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
 		int, fd_out, loff_t __user *, off_out,
 		size_t, len, unsigned int, flags)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..2961fee3e5cc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -505,7 +505,7 @@ enum {
 	SKBFL_ZEROCOPY_ENABLE = BIT(0),
 
 	/* This indicates at least one fragment might be overwritten
-	 * (as in vmsplice(), sendfile() ...)
+	 * (as in sendfile(), ...)
 	 * If we need to compute a TX checksum, we'll need to copy
 	 * all frags to avoid possible bad checksum
 	 */
@@ -4017,7 +4017,7 @@ static inline int skb_linearize(struct sk_buff *skb)
  * @skb: buffer to test
  *
  * Return: true if the skb has at least one frag that might be modified
- * by an external entity (as in vmsplice()/sendfile())
+ * by an external entity (as in sendfile())
  */
 static inline bool skb_has_shared_frag(const struct sk_buff *skb)
 {
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f..fb4f035aae83 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -19,7 +19,7 @@
 				 /* we may still block on the fd we splice */
 				 /* from/to, of course */
 #define SPLICE_F_MORE	(0x04)	/* expect more data */
-#define SPLICE_F_GIFT	(0x08)	/* pages passed in are a gift */
+#define SPLICE_F_GIFT	(0x08)	/* ignored */
 
 #define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f5639d5ac331..a86a88207956 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -514,8 +514,8 @@ asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
 			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
 asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
-asmlinkage long sys_vmsplice(int fd, const struct iovec __user *iov,
-			     unsigned long nr_segs, unsigned int flags);
+asmlinkage long sys_vmsplice(unsigned long fd, const struct iovec __user *vec,
+			     unsigned long vlen, unsigned int flags);
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
 			   size_t len, unsigned int flags);
-- 
2.47.3


