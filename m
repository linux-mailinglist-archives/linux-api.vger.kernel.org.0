Return-Path: <linux-api+bounces-2345-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C3987EBB
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 08:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC2F280E4F
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A615E5C8;
	Fri, 27 Sep 2024 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9RcEWKz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AA15D5C1;
	Fri, 27 Sep 2024 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419975; cv=none; b=GWOvbUa/9IBjYZENRRruEMMU4P7NU5MdACnYxWPPLKGIqdTd99BXwaPdlcjC4ma5fIXU3FlmGwVROxX7qBfh31ztLNzRrVZE8G0K7cQaeN2vgS2Kj1YSoQBP4ruwevf1oaOn5rBicTWtZkMWk1EQ4Xd5fvND/glEQrtYKFqrYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419975; c=relaxed/simple;
	bh=D85vgrtDpZI98vi53liCsQQ+BxQvK2UuXBHp/M7xbTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=joy0W6NbDo2LvAmCVJ0GyfFmviRRYU2I+2Fl6loS4BsdO9xlOWuiDotPp548h7ISvhC8tWGjjLZYLTKYNlQMhJjVzU74JkWxFZZe1AOdenOChxxb86VF4nfAKmAy+vrzZ7RliDbsaa3UlA4rpVnTTK7VwE8iSZegf6IHcU4fFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9RcEWKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11007C4CEC4;
	Fri, 27 Sep 2024 06:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727419975;
	bh=D85vgrtDpZI98vi53liCsQQ+BxQvK2UuXBHp/M7xbTI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=c9RcEWKzG8HtlXroCEJJsCjGW1ute+0oNBint11DGSXXYwZhbluO/mrKEmoCRTWbb
	 9wP9yk7VCG044JfLBtvUTFTy0TjfOCDqVkEZQZ/zVm3ACbdHa1qLy4my4LrwCVSpDj
	 YT/3+azoNsO6HQVSwpe/wXWszqzWlqh3xNX2oF7W8B8etf6cfKRfH6cDIpTv4CqJuX
	 1i1QA7XparxbUdrMBp1Ho81vkivBa3yugqy+vL5A4kOFJr6h4dovNX7lN6smqT7R7r
	 dNWZeBodi9YVz+2/j+jwW63vfVUJV5GqMjS6l/NO7qpyMCgKzyuKS5a4EQHsuVaTvu
	 Cnk3HpTeDo0QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0057DCEBF7A;
	Fri, 27 Sep 2024 06:52:54 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Fri, 27 Sep 2024 14:52:29 +0800
Subject: [PATCH] dup.2: Add ENOMEM to ERRORS
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-dup2-v1-1-12ecc79167d5@outlook.com>
X-B4-Tracking: v=1; b=H4sIACxW9mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyNz3ZTSAiNdcyPzVEsLs1RDSwMDJaDSgqLUtMwKsDHRsbW1ACQQ8Il
 WAAAA
X-Change-ID: 20240927-dup2-727e986e1900
To: linux-man@vger.kernel.org
Cc: Linux API <linux-api@vger.kernel.org>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=WlIAO1mmcIQbRV8l8FS+BAcsh1rqVPTGYW1EOb7BydQ=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBm9lZCu+Ky5T0AQ2EUB/Q8m+ikUppvTf5hC86fT
 GAVS9GjICCJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZvZWQgAKCRBvO5jUL8bJ
 2COJD/0fLyAlWF+2IOOQeGVFF8Gn9EbRqiotZGkyQFbEAPbPPrpY6o704u7v22jXcLYfwwswF2s
 wZ5dJKIv67HYW57AOBBQNWhPSzygMHb4BD3BxfPFSy9nGsMHCKZ0l8oiYENa8zY4sh2j+iq6fjJ
 JQQyDlfSR5vn4BiZdcBnwJc+tqpRIWnKNWzu2ORgpQLGmM856G6f8tgWXg/dOYaLnBffKzXi8fF
 230c9f6OU4Gg98ctngfvn9wsBdEMrCqLCYdn5frkybHk0MMwie0XvVlpgd9UNu8ixBz1ikGcqrU
 dFAO9sR/8L4rDE3axKl+uUcN4PXfM9hPe5RPkuMYHiF9YX/+KuyEsNjbN9CY+RyBRL5cKmmILHz
 sl3wo4SyxqSduTJw36ieGzWB4uUPX+YyJRVOfki0N4+kCTomlzEZ8HIHwf+Ts/7WG10SgPKBTk6
 nahzQlPkWNS3JiXRhad4WOYY2B30Gnqic4JbhsCNaWsYmdMzll9Dr5rOVNgkiniQbb1MqVtIeW2
 JmtOC7cGzhs7Hj5fgvO9T55LqSvfucSQKagnME8H0ROzcEaupt+qHJhPQJdHDQa7yv5SqXGVzEr
 mSOjgwa2W38hSPkTBlE2FMikatjQZISNzh3WKba6Mj4X7FSFauCTB+IBR4Stoi8+Tgy3CfDy+Di
 RWR0GmzKy2gTk1g==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

dup2 could return ENOMEM under extreme condition.
For example, when sysctl fs.nr_open=2147483584, and RLIMIT_NOFILE is also
2147483584. The following program fails with ENOMEM:

int main(){
  int ret = dup2(0, 2000000000);
  if (ret < 0) {
    perror("dup2");
    return 1;
  }
  return 0;
}

This ENOMEM comes from an allocation error here:
https://elixir.bootlin.com/linux/v6.1/source/mm/util.c#L596

ENOMEM is already documented for open(2).

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
While experimenting with fs.nr_open sysctl and RLIMIT_NOFILE,
I noticed that dup(2) could return an undocumented errno ENOMEM.
This patch add ENOMEM to ERRORS in dup.2.
---
 man/man2/dup.2 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/man/man2/dup.2 b/man/man2/dup.2
index ee964a827ca062d90419c7d39f457de270d42ca3..719f0ae9e78165733cbe607bbf8a803a5d0943b4 100644
--- a/man/man2/dup.2
+++ b/man/man2/dup.2
@@ -197,6 +197,9 @@ .SH ERRORS
 .B RLIMIT_NOFILE
 in
 .BR getrlimit (2)).
+.TP
+.B ENOMEM
+Insufficient kernel memory was available.
 .SH STANDARDS
 .TP
 .BR dup ()

---
base-commit: 1e2d36deb2de1dbaf7084bb7dc3cb2c170cce852
change-id: 20240927-dup2-727e986e1900

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



