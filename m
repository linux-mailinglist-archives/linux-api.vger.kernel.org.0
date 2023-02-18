Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09E69B71C
	for <lists+linux-api@lfdr.de>; Sat, 18 Feb 2023 01:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBRApK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Feb 2023 19:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjBRApI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Feb 2023 19:45:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267C6D7A8
        for <linux-api@vger.kernel.org>; Fri, 17 Feb 2023 16:44:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365a29685dso19446567b3.12
        for <linux-api@vger.kernel.org>; Fri, 17 Feb 2023 16:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mwmDPnm22mSNSwTn0VodViIvXaPz9XlM8QDWYhbyM8=;
        b=eMm01hnumElMl3UotGf8lJtLmKUjjLEmp4ZHK0o1H0LRyNA5w7x33BZeE7ifCfM7pg
         Cd3CBejXIUZT0dDASkiYet2Q11r1oqaxT2jWL7729gQTvNyIV+Z3A265SCXl8KKZFvM6
         J2aSWma9rqTSDwyH7vONqfORZObAwWA+6hRLW5QjldLuMtFrDr6CiZLUw313wtVBTkEY
         Uql860ZaIf2fzbiPBXmxv8De94uhU4jaykP5woFVxM5M2xVs65vFvbC27a8oelqLROik
         ucodFnqa/c0QR5Ark7refIrmAYAsOKE19K26vuVEVEq0bwodrw1HGi4stiNrcoXlrrSh
         sdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mwmDPnm22mSNSwTn0VodViIvXaPz9XlM8QDWYhbyM8=;
        b=fGXfegZKoyp12v1LEFYmklI22RHFAtJV10FUSSjb9lLAV/Y/8A7+ewyzyVwPG0tkC3
         JI1ZlJ8L9j5VBF3+BJc54nkp7cPMXHupHv5GDFTOd9frw9CY95ZHX2iSYtZIaTDz/a8f
         loBPDcuUoyCM75OGlhTbIoNrJ9DLvt8bDyx6Tw+AMs+UoPB7B9Aiek5guYLlpep/OUVR
         FDRd1BGj2kQtRQgUH1o3bwcaVVlXWt2GsswFfR6jzPKm9OpRgIkQN4G9E9RNoMEVs+W5
         m6xMqxHrekOoHTuRSjEXr1lNSlHpk8fKmJqYxvAO47l/wnlBYY7SxdEg8Wz7pkP3ebW8
         nEAg==
X-Gm-Message-State: AO0yUKUQRdFcCQ1h9ASFYMVZI+FXShMEcxwBOPPq7ZSg6jYBVt3S71n6
        ZjFbGKvYHHJ4T4JX53zWt+kx7KnqyC939QYaCA==
X-Google-Smtp-Source: AK7set8GCw+l6Q5gppx0SI7xgHF70UCy3j05OUIa+XJfbCoB3vIVoiRjffivwnfUze8k0uHuDZvSsWzxIhc/w0Mo2w==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:10e:b0:95d:6b4f:a73a with
 SMTP id o14-20020a056902010e00b0095d6b4fa73amr5895ybh.8.1676681001601; Fri,
 17 Feb 2023 16:43:21 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:43:02 +0000
In-Reply-To: <cover.1676680548.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1676680548.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <67956539824ea9dd66a94d67b046b2f4bb0aa6f2.1676680548.git.ackerleytng@google.com>
Subject: [RFC PATCH 2/2] selftests: restrictedmem: Add selftest for RMFD_HUGEPAGE
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Tests that when RMFD_HUGEPAGE is specified, restrictedmem will be
backed by Transparent HugePages.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../restrictedmem_hugepage_test.c             | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c b/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
index 0d9cf2ced754..75283d68696f 100644
--- a/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
+++ b/tools/testing/selftests/restrictedmem/restrictedmem_hugepage_test.c
@@ -180,6 +180,31 @@ TEST_F(reset_shmem_enabled, restrictedmem_fstat_shmem_enabled_always)
 	close(mfd);
 }
 
+TEST(restrictedmem_invalid_flags)
+{
+	int mfd = memfd_restricted(99, NULL);
+
+	ASSERT_EQ(-1, mfd);
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(reset_shmem_enabled, restrictedmem_rmfd_hugepage)
+{
+	int mfd = -1;
+	struct stat stat;
+
+	ASSERT_EQ(0, set_shmem_thp_policy("never"));
+
+	mfd = memfd_restricted(RMFD_HUGEPAGE, NULL);
+	ASSERT_NE(-1, mfd);
+
+	ASSERT_EQ(0, fstat(mfd, &stat));
+
+	ASSERT_EQ(stat.st_blksize, get_hpage_pmd_size());
+
+	close(mfd);
+}
+
 TEST(restrictedmem_tmpfile_no_mount_path)
 {
 	int mfd = memfd_restricted(RMFD_TMPFILE, NULL);
-- 
2.39.2.637.g21b0678d19-goog

