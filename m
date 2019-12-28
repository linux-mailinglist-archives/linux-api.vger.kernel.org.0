Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6987A12BC2C
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 02:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfL1Bsn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 20:48:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38700 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfL1Bsn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 20:48:43 -0500
Received: by mail-io1-f66.google.com with SMTP id v3so27159861ioj.5
        for <linux-api@vger.kernel.org>; Fri, 27 Dec 2019 17:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NY2N4q5Dac+G88QX+oQjP46FWyhBolRVkhJcTyB0XSo=;
        b=AEifvLg1nqDmp9j2ESQm2zzI2MO5rNW2M5ASqEAimcXs9HyA9NLhkvdkmRoXpxyKEQ
         9H+w3XUhlzcfJ4qB2kS3Nxy5XW1JVEwJY+erWyk2+hsRB/DwVVMUMalmFpSpuruVqs1H
         hpNbeRboKp2kj1jJq0MCes+u5klrU7+OQo31U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NY2N4q5Dac+G88QX+oQjP46FWyhBolRVkhJcTyB0XSo=;
        b=I4MfmykWXC4XvlcqVAxNm96vUyrGEeybdmTQGBii3XZh5qtbTSE3iJMxlOWUB4xp2W
         D7c5oZO31gb4Wig9xTTCN3kRu60zODMDYKaiVqWINFy6T10fI0JLmf+7zRdfibLIOPJm
         pDyG4kgBOZuIuRlaIKdX+FTpucWWlTegPYwweGc+997zbJAon00GF/i5xkP1vgE2AOyR
         /2DtLZlUHzvRZHqL0i0jsSxkaoto49ygIXAR+QQoDijlAQCxlT4y0JU95Tn8eML/fiSL
         4k/lF7nFQqbMUs2CYfuLUiweXGHU2+639ORdHPQbFgw2YgHtoBbhe0PsCxvKhX3QbMbS
         IaoQ==
X-Gm-Message-State: APjAAAV3DFTqiXSHKT385MGCnzEMQVa+xmtXu5ZNoNl1I3n2pxN3rHyH
        8tw7hmw7PF5yT1hcwIXZYjY0sg==
X-Google-Smtp-Source: APXvYqwcPOG8gPwaOwCX82CyVx5cT0LbTQVBKS6Z2IFjbBcGslggL1KjxiZZntuVXmmryyJ0R0XBzA==
X-Received: by 2002:a02:aa11:: with SMTP id r17mr43270716jam.88.1577497721350;
        Fri, 27 Dec 2019 17:48:41 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id w11sm12061922ilh.55.2019.12.27.17.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 17:48:40 -0800 (PST)
Date:   Sat, 28 Dec 2019 01:48:39 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org, cyphar@cyphar.com
Subject: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The seccomp_notif structure should be zeroed out prior to calling the
SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
whether these structures were zeroed out or not, so these worked.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Kees Cook <keescook@chromium.org>
---
 samples/seccomp/user-trap.c                   | 2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 6d0125ca8af7..0ca8fb37cd79 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -298,7 +298,6 @@ int main(void)
 		req = malloc(sizes.seccomp_notif);
 		if (!req)
 			goto out_close;
-		memset(req, 0, sizeof(*req));
 
 		resp = malloc(sizes.seccomp_notif_resp);
 		if (!resp)
@@ -306,6 +305,7 @@ int main(void)
 		memset(resp, 0, sizeof(*resp));
 
 		while (1) {
+			memset(req, 0, sizes.seccomp_notif);
 			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
 				perror("ioctl recv");
 				goto out_resp;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6944b898bb53..f53f14971bff 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3278,6 +3278,7 @@ TEST(user_notification_signal)
 
 	close(sk_pair[1]);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	EXPECT_EQ(kill(pid, SIGUSR1), 0);
@@ -3296,6 +3297,7 @@ TEST(user_notification_signal)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), -1);
 	EXPECT_EQ(errno, ENOENT);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	resp.id = req.id;
-- 
2.20.1

