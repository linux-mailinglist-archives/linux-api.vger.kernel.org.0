Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AFA24CF6E
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgHUHjD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Aug 2020 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgHUHiy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Aug 2020 03:38:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB0C06138B
        for <linux-api@vger.kernel.org>; Fri, 21 Aug 2020 00:38:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so606929pgi.9
        for <linux-api@vger.kernel.org>; Fri, 21 Aug 2020 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbNZE5EUMG3BjXEiJ181XCt1kROeQ09EehF/ZeJbJZc=;
        b=EiDDS+RlL7NRC3vJsn68m59XKvD9RaJJMZrqSCQ8d5QGhjaAgm31pzaitQG5/0cf/3
         4xA0/3PSDviWS44gfeuiVlsrj2LceKZdmWnEvcPF7lgLif7o8QyV+eSFBOCsiWBpCbVr
         EpRzRiKJ4hxiyyRwSGk+zCSFHsHJbPXdoXWK5Dcjux1OoK6jtfSVqNKxdVXeBHQZyZMO
         1x5Vxd0xcX2l8gV0DpabmXwJ5BqKSphyyjyIHNTq6uOX78QeHLWo91hehp2T9RUnonVR
         MZacudvfNUVFx5B0FMQIkqLMnoDIaSZoQdQW6S0ishOQOsJU3hqRzb3nCJ6gLBagrpwX
         cX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbNZE5EUMG3BjXEiJ181XCt1kROeQ09EehF/ZeJbJZc=;
        b=QNN+HA9TAeqq8QzIuud5RNADjRp7Kil9DvAG2yWGOp+ckQclrcf0COpfPcUEA4QOPW
         z2ug9kiSRa2Q8tOm/y/bpTjdLwIcgiiBgH1UH2084n7du0iv5IsnwPTrD4/wxwkLrRzm
         bqez6BVzF0Cb6dij5sKXymmCP+cLlz3nb2slAvNpo2SJg8WUJ4dNwwMbaHtfoDPJTaog
         7jeBVRINqnNc0bP1uJrhs08SjSFWSGRrB/nmVpjof12gU78BsUs7r2mnbyCkAz6f9FNb
         OdLjz/8n7M3O4srbKPECG5cNLpzNZ4L/0lzzYq3DPfb5ikBhLOcgGjGkUJntkScwwF0L
         qSBg==
X-Gm-Message-State: AOAM531At6oEG1+XVWF4e00TnyIxV0S3RS1ZFQlDFjo5og2xwzWsZR1F
        3r1Fa9VHLnlE+WujzxyqTvakMg==
X-Google-Smtp-Source: ABdhPJyVLFv3sJdKcYXujphx1VB63apU83QnLh3+ScdVNhU0JvrvFb7x8jdnjjhwwqfAbMlU9PbiIw==
X-Received: by 2002:a63:cc49:: with SMTP id q9mr1382045pgi.390.1597995533642;
        Fri, 21 Aug 2020 00:38:53 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:38:52 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 1/9] iov_iter: add copy_struct_from_iter()
Date:   Fri, 21 Aug 2020 00:38:32 -0700
Message-Id: <8010f8862ec494c631b1d7681a6c5886d12f60df.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is essentially copy_struct_from_user() but for an iov_iter.

Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 3835a8a8e9ea..2b80cd073d83 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -121,6 +121,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..cb320f7f6628 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -944,6 +944,88 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
+/**
+ * copy_struct_from_iter - copy a struct from an iov_iter
+ * @dst: Destination buffer.
+ * @ksize: Size of @dst struct.
+ * @i: Source iterator.
+ * @usize: (Alleged) size of struct in @i.
+ *
+ * Copies a struct from an iov_iter in a way that guarantees
+ * backwards-compatibility for struct arguments in an iovec (as long as the
+ * rules for copy_struct_from_user() are followed).
+ *
+ * The recommended usage is that @usize be taken from the current segment:
+ *
+ *   int do_foo(struct iov_iter *i)
+ *   {
+ *     size_t usize = iov_iter_single_seg_count(i);
+ *     struct foo karg;
+ *     int err;
+ *
+ *     if (usize > PAGE_SIZE)
+ *       return -E2BIG;
+ *     if (usize < FOO_SIZE_VER0)
+ *       return -EINVAL;
+ *     err = copy_struct_from_iter(&karg, sizeof(karg), i, usize);
+ *     if (err)
+ *       return err;
+ *
+ *     // ...
+ *   }
+ *
+ * Return: 0 on success, -errno on error (see copy_struct_from_user()).
+ *
+ * On success, the iterator is advanced @usize bytes. On error, the iterator is
+ * not advanced.
+ */
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize)
+{
+	if (usize <= ksize) {
+		if (!copy_from_iter_full(dst, usize, i))
+			return -EFAULT;
+		memset(dst + usize, 0, ksize - usize);
+	} else {
+		size_t copied = 0, copy;
+		int ret;
+
+		if (WARN_ON(iov_iter_is_pipe(i)) || unlikely(i->count < usize))
+			return -EFAULT;
+		if (iter_is_iovec(i))
+			might_fault();
+		iterate_all_kinds(i, usize, v, ({
+			copy = min(ksize - copied, v.iov_len);
+			if (copy && copyin(dst + copied, v.iov_base, copy))
+				return -EFAULT;
+			copied += copy;
+			ret = check_zeroed_user(v.iov_base + copy,
+						v.iov_len - copy);
+			if (ret <= 0)
+				return ret ?: -E2BIG;
+			0;}), ({
+			char *addr = kmap_atomic(v.bv_page);
+			copy = min_t(size_t, ksize - copied, v.bv_len);
+			memcpy(dst + copied, addr + v.bv_offset, copy);
+			copied += copy;
+			ret = memchr_inv(addr + v.bv_offset + copy, 0,
+					 v.bv_len - copy) ? -E2BIG : 0;
+			kunmap_atomic(addr);
+			if (ret)
+				return ret;
+			}), ({
+			copy = min(ksize - copied, v.iov_len);
+			memcpy(dst + copied, v.iov_base, copy);
+			if (memchr_inv(v.iov_base, 0, v.iov_len))
+				return -E2BIG;
+			})
+		)
+		iov_iter_advance(i, usize);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_struct_from_iter);
+
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.28.0

