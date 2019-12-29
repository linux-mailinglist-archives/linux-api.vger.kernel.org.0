Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1712C0F0
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 07:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfL2Gmn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 01:42:43 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38778 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfL2Gmm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 01:42:42 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so25557083ilq.5
        for <linux-api@vger.kernel.org>; Sat, 28 Dec 2019 22:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10zDnvpvgJY3+fg2idIElI8KZXsWauju2j/O5QjINPQ=;
        b=cJFapQrL43W7gizsvi1Gn3JwV1FWqQA4NyrNvcOgzUbs6M2WgdBaHksuPstTqPyNFD
         BlAgPYao7368C21/i4nvGYEG4/wnwzAvD3yGp8/PfkasQJqh/0Ksuoqi1o5Ep/efP4zD
         RYHf96bjqdbO5T5fFgz9Qas1ec1f4Pe9qvuVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10zDnvpvgJY3+fg2idIElI8KZXsWauju2j/O5QjINPQ=;
        b=cHNKUTuSal7MdMkZ50wlu6Qb5SsaCBHJthtYY5LHKo9+2TMLPn0UVrnsAQ6eccXUYq
         X3EEeC6Gky7f8PTmvxPLdFzVdGjweOcBAgdMkv2Iv1TG2hHLLRb7EJ4QcbMLQVGMeV2T
         bp2ZV8oZ0nbIRZfvlBfH2Bjb2cpRSLWhZWYrdkXWCKukR3U08O/+atkQHuIhRZ/ljCra
         HjgjUj84lzZxhf3Q40ZtHpzSu4DhzyRCPuq5QzsxWW67lFxw/uaUjwQ0EhaXfyiiCIRB
         ftRCpZKHWMF/IMUrMN6V1UW/uxW+amGJ88W5BEVC2j1GimAKs1VyHiD3kbCWLd1DsAtx
         Z7lw==
X-Gm-Message-State: APjAAAUcUVvU7brcs8/l3pQnyIJtRpA4Z7Jo6/sct/qyb5J7ijwNhPYT
        y6XNxooeEIRnQTK6cRzx2Bb/BQ==
X-Google-Smtp-Source: APXvYqx/5yGsPjRrGqz8fHb4ldYyebxYGMXrnGmwZO/fEW75acLlzFOlNbO0o976zYKLoK7NQZ85jg==
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr53014267ilq.38.1577601762024;
        Sat, 28 Dec 2019 22:42:42 -0800 (PST)
Received: from ubuntu.netflix.com ([75.104.68.239])
        by smtp.gmail.com with ESMTPSA id y11sm15112053ilp.46.2019.12.28.22.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 22:42:41 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v3 2/3] seccomp: Check that seccomp_notif is zeroed out by the user
Date:   Sat, 28 Dec 2019 22:24:50 -0800
Message-Id: <20191229062451.9467-2-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191229062451.9467-1-sargun@sargun.me>
References: <20191229062451.9467-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch is a small change in enforcement of the uapi for
SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
is passed (seccomp_notif) must be zeroed out. Previously any of its
members could be set to nonsense values, and we would ignore it.

This ensures all fields are set to their zero value.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Acked-by: Tycho Andersen <tycho@tycho.ws>
---
 kernel/seccomp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 12d2227e5786..b6ea3dcb57bf 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
+	/* Verify that we're not given garbage to keep struct extensible. */
+	ret = check_zeroed_user(buf, sizeof(unotif));
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EINVAL;
+
 	memset(&unotif, 0, sizeof(unotif));
 
 	ret = down_interruptible(&filter->notif->request);
-- 
2.20.1

