Return-Path: <linux-api+bounces-286-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79852808E3D
	for <lists+linux-api@lfdr.de>; Thu,  7 Dec 2023 18:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AF91F2113E
	for <lists+linux-api@lfdr.de>; Thu,  7 Dec 2023 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB1481DC;
	Thu,  7 Dec 2023 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="lEMjDWfa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1PQHIdI"
X-Original-To: linux-api@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C03D1;
	Thu,  7 Dec 2023 09:10:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9C4593200B2F;
	Thu,  7 Dec 2023 12:10:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 12:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701969003; x=
	1702055403; bh=4sDD4mN+pIoyX7m8FGv2uCwfMAv7UW1AZsJ3O0T01T8=; b=l
	EMjDWfa2vDs4yANCD1jQOkuNvlFfdzI5xybWdTcJj+YFMgqLr3bk7NBZ0+4Q4tqk
	iDlaUq1f+lxSK22cjB+hY+wgiKBULcQ1mj52FJ4VD1hwOSFQYitRaqbhPApK25vm
	+2axUaWS9IeeAPfEzRqAb5dqEty5zqX2sNvDPpF+3g2qKfHsTT3iOKTnFVavbB32
	Yacb/Lhgk0UgMqqnGlJHRCGvcwEVxbYoCvaewY+D1Mdqpigc7w0tCSpbuSiwbkib
	BLTVdODDsPkobBCWo9195+26FLTx+JPJvGDHy5KVuV25NvWqcfVsnIOj0+ulYCbW
	iqZBxP645biAaDjes5zXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701969003; x=
	1702055403; bh=4sDD4mN+pIoyX7m8FGv2uCwfMAv7UW1AZsJ3O0T01T8=; b=R
	1PQHIdIkO7E6C8glYwyeNLHUY+8rY63AWROIR32A7hn+EYPHrjP0+n8Awdvqx0LZ
	PKVArumjrkXKKxSphi3P/DjFdKPcPEYJqcZfKBw9eZSscQJVjdcaKxfK6JdSGWcZ
	orbu4g+1KpmhTsIqAHXRsEZSEzYJyp2jbq6EXNGKe2t0VNooyAtTdD8uvMLtrF5j
	L9kBSOLAQoBEG/0v5q4awbeX5vUDY2JVDuqknawv/fSGGWd0Lhpmdh/+OuaH4dkA
	FDcJ/grSPCnCHVz5v421m7urlIvaoCu5XB3Fccs63vF78HEN2qh+x9QiMHWWbJQ0
	xU28BgqNZnEY1x6jbRXrg==
X-ME-Sender: <xms:avxxZTwXoL4BvB3dThv4PBCc8XTQgzFQvk14CBh8QOeB-RiIrZM9sw>
    <xme:avxxZbToT7rVwtFpaoHCUOGGqStewHA8NVlFJf-yUlbph_DbIBz9aUrHguA2oVRyG
    oNSOgwuD9oYFw1xKZo>
X-ME-Received: <xmr:avxxZdUkaLRfw7FW1FOgR-AHsAD1_YW0tV28dQSqSO-KDp4CrLOQUe1aOAPZkthbMFM-ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:avxxZdh4rlAqRwEYEUA2IVKzYjQpZ1Mg-yvIeWj19V3QxKSSDNmAMw>
    <xmx:avxxZVBIPw5fBWh6xX2vB5lL-80MTAKa5QzHxaXCwAPLLzjKQqbvQg>
    <xmx:avxxZWJGkHaCroBomL39ofu-hi-rORiyDiMdGF87GVFPEfz727Zx6Q>
    <xmx:a_xxZY4SbNy5ppz66f3kqDUea6rcZFYys_tb3RWfSKKywoVW0uyvaQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 12:10:01 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v2 3/3] clone: allow CLONE_THREAD | CLONE_PIDFD together
Date: Thu,  7 Dec 2023 10:09:46 -0700
Message-Id: <20231207170946.130823-3-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207170946.130823-1-tycho@tycho.pizza>
References: <20231207170946.130823-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

This removes the restriction of CLONE_THREAD | CLONE_PIDFD being specified
together. Assuming the previous patch sorts out all the thorny issues this
should be safe. I've left it as a separate patch since it is not strictly
necessary as a usecase for us, but might be nice? Perhaps we want to wait
until someone actually needs it though.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 kernel/fork.c                                   |  3 +--
 .../selftests/pidfd/pidfd_non_tgl_test.c        | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index eef15c93f6cf..ada476f38b56 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2302,9 +2302,8 @@ __latent_entropy struct task_struct *copy_process(
 		/*
 		 * - CLONE_DETACHED is blocked so that we can potentially
 		 *   reuse it later for CLONE_PIDFD.
-		 * - CLONE_THREAD is blocked until someone really needs it.
 		 */
-		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
+		if (clone_flags & CLONE_DETACHED)
 			return ERR_PTR(-EINVAL);
 	}
 
diff --git a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
index e3992f2d88cf..dfd6a2cd85a3 100644
--- a/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_non_tgl_test.c
@@ -305,6 +305,22 @@ static int test_non_tgl_exit(void)
 	return ret;
 }
 
+static int test_clone_thread_pidfd(void)
+{
+	pid_t pid;
+	int flags = CLONE_THREAD | CLONE_VM | CLONE_SIGHAND | CLONE_PIDFD;
+	int pidfd;
+
+	pid = clone(thread_sleep, stack + STACK_SIZE, flags, NULL, &pidfd);
+	if (pid < 0) {
+		perror("clone");
+		return KSFT_FAIL;
+	}
+
+	close(pidfd);
+	return KSFT_PASS;
+}
+
 #define T(x) { x, #x }
 struct pidfd_non_tgl_test {
 	int (*fn)();
@@ -313,6 +329,7 @@ struct pidfd_non_tgl_test {
 	T(test_non_tgl_basic),
 	T(test_non_tgl_exec),
 	T(test_non_tgl_exit),
+	T(test_clone_thread_pidfd),
 };
 #undef T
 
-- 
2.34.1


