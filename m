Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6097E12BC2E
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfL1Bs4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 20:48:56 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33435 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfL1Bsz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 20:48:55 -0500
Received: by mail-il1-f195.google.com with SMTP id v15so23670072iln.0
        for <linux-api@vger.kernel.org>; Fri, 27 Dec 2019 17:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DDPiRYZKbt5YXi2Y+CUXPuPnWcpqDrbVx/b405CuP1A=;
        b=z7N+czYvcFoUZNOTteUd/f/rHfciJ4hgUaWHyQLVN5HHfSLwU/odrwm8TCvckRM1ly
         ECiTcJMDn+llLl4v7RwW7/seiD9hC+3Z/OcMSSJLjNm3T81PtQp7QHh3x6VedLLacFIz
         ZelH1jhe171qCQkU34vsmEkQtwU982tQ6EZvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DDPiRYZKbt5YXi2Y+CUXPuPnWcpqDrbVx/b405CuP1A=;
        b=h3eRG8Z+yuo/hnwwhITqO3WNCBIju6oQZd17AQ8KFrx3+sncUk4AgB5QtoBrf3r72b
         VcEzHmbpK29uDd6PuRsGclenuTJMQYUnYxX5iDnbiBQJ5YqkXUYcgH0b02Jp6dm7V9SK
         JEM8hZ5yJQhaXTH+v8tc1DJt/DS1UKY33xkeGeQpv0WuUvj1Cd9I6f8z1R98dme0GQVb
         +9kjXOJFvhwAuPugnCUqPvxIi4F2ywXwFXFcf0G2/j4RNCqLf4LGZlRnT1XmiZ+x+Bke
         8qmXKwnnzlrBcbyFvUqL9Qka804k3r/NZcqHYJ1QzrnvRsQx7xmftJ8HEi1NQBcbr7wG
         VrWw==
X-Gm-Message-State: APjAAAXFikzOht6/klG9JpnpQLVaJGF946NBhJAg1dqoCLQ5bng+adug
        rHKwHQM5GzwcuGqyZk1D3PVvgA==
X-Google-Smtp-Source: APXvYqyoZZo9NvOdbd3yORVqoHuqAGtvfcLRDigiJZrZTHX2eNvyhqnZsRdvRYWzRUMcl3T4o0CDSw==
X-Received: by 2002:a92:b6db:: with SMTP id m88mr34585103ill.220.1577497733231;
        Fri, 27 Dec 2019 17:48:53 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id n20sm9732216ioj.83.2019.12.27.17.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 17:48:53 -0800 (PST)
Date:   Sat, 28 Dec 2019 01:48:51 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org, cyphar@cyphar.com
Subject: [PATCH v2 2/2] seccomp: Check that seccomp_notif is zeroed out by
 the user
Message-ID: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch is a small change in enforcement of the uapi for
SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
is passed (seccomp_notif) must be zeroed out. Previously any of its
members could be set to nonsense values, and we would ignore it.

This ensures all fields are set to their zero value.

This relies on the seccomp_notif datastructure to not have
any unnamed padding, as it is valid to initialize the datastructure
as:

  struct seccomp_notif notif = {};

This only initializes named members to their 0-value [1].

[1]: https://lore.kernel.org/lkml/20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com/

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 12d2227e5786..4fd73cbdd01e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1026,6 +1026,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
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

