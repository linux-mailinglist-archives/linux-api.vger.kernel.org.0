Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF78951DD52
	for <lists+linux-api@lfdr.de>; Fri,  6 May 2022 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiEFQRf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 May 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443769AbiEFQRU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 May 2022 12:17:20 -0400
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 09:12:38 PDT
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921CC712ED
        for <linux-api@vger.kernel.org>; Fri,  6 May 2022 09:12:38 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS22VjzzMqwSb;
        Fri,  6 May 2022 18:06:58 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS20gxszlhSLv;
        Fri,  6 May 2022 18:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853218;
        bh=yivXrqwHOjEJuB5JO2dFkVkVifT0vIdSPlaZ68dxcTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvtnmkxj8G1I3mF9KjXpG4pgD7uoCILsZIPoo5A7yu4bfGGeLBSKir4P1G2+Bug/W
         PHN2E38FCKMoMVLe7wIYjF2pABAeE9nCUAece9ecWukrrw27RRIc5wcPMLuZSNxcT0
         Grtvtx+sJ/JoLha/UImCZLqdx93NLKZlkj+qVEo4=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 01/10] landlock: Fix landlock_add_rule(2) documentation
Date:   Fri,  6 May 2022 18:08:11 +0200
Message-Id: <20220506160820.524344-2-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It is not mandatory to pass a file descriptor obtained with the O_PATH
flag.  Also, replace rule's accesses with ruleset's accesses.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-2-mic@digikod.net
---
 include/uapi/linux/landlock.h | 5 +++--
 security/landlock/syscalls.c  | 7 +++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 15c31abb0d76..21c8d58283c9 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -62,8 +62,9 @@ struct landlock_path_beneath_attr {
 	 */
 	__u64 allowed_access;
 	/**
-	 * @parent_fd: File descriptor, open with ``O_PATH``, which identifies
-	 * the parent directory of a file hierarchy, or just a file.
+	 * @parent_fd: File descriptor, preferably opened with ``O_PATH``,
+	 * which identifies the parent directory of a file hierarchy, or just a
+	 * file.
 	 */
 	__s32 parent_fd;
 	/*
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 2fde978bf8ca..7edc1d50e2bf 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -292,14 +292,13 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
  *
  * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
- *   &landlock_path_beneath_attr.allowed_access is not a subset of the rule's
- *   accesses);
+ *   &landlock_path_beneath_attr.allowed_access is not a subset of the
+ *   ruleset handled accesses);
  * - ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
  * - EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
- *   @rule_attr is not the expected file descriptor type (e.g. file open
- *   without O_PATH);
+ *   @rule_attr is not the expected file descriptor type;
  * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
  * - EFAULT: @rule_attr inconsistency.
  */
-- 
2.35.1

