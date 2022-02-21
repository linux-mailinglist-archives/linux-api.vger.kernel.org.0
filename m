Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5464BE09D
	for <lists+linux-api@lfdr.de>; Mon, 21 Feb 2022 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiBUPxT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Feb 2022 10:53:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379679AbiBUPxR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Feb 2022 10:53:17 -0500
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 07:52:53 PST
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311062654E
        for <linux-api@vger.kernel.org>; Mon, 21 Feb 2022 07:52:51 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2RQs5CPKzMptjp;
        Mon, 21 Feb 2022 16:43:17 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2RQr4xqLzlhMBl;
        Mon, 21 Feb 2022 16:43:16 +0100 (CET)
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
Subject: [PATCH v1 0/7] Minor Landlock fixes and new tests
Date:   Mon, 21 Feb 2022 16:53:04 +0100
Message-Id: <20220221155311.166278-1-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

This series contains landlock_add_rule(2) (cosmetic) signature and
documentation fixes.  There is also some miscellaneous new tests to
improve coverage and that may help for future access types (e.g.
networking).

Regards,

Mickaël Salaün (7):
  landlock: Fix landlock_add_rule(2) documentation
  landlock: Fix landlock_add_rule(2) signature
  selftest/landlock: Make tests build with old libc
  selftest/landlock: Extend tests for minimal valid attribute size
  selftest/landlock: Add tests for unknown access rights
  selftest/landlock: Extend access right tests to directories
  selftest/landlock: Fully test file rename with "remove" access

 include/linux/syscalls.h                     |  3 +-
 include/uapi/linux/landlock.h                |  5 +-
 security/landlock/syscalls.c                 | 14 ++--
 tools/testing/selftests/landlock/base_test.c |  5 ++
 tools/testing/selftests/landlock/fs_test.c   | 84 ++++++++++++++++----
 5 files changed, 86 insertions(+), 25 deletions(-)


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.35.1

