Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466BD6BC291
	for <lists+linux-api@lfdr.de>; Thu, 16 Mar 2023 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjCPAbg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Mar 2023 20:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjCPAb3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Mar 2023 20:31:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9509EF76
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 17:31:19 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s20-20020a056a00179400b005c4d1dedc1fso174480pfg.11
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vx2+K6b7VucsfYU5uvwShdem3MP0VCFQdKNh537WPsg=;
        b=PAaXwSJqPjUc6R/biIaCW2VNIfg9P921yoYdsBglXW7n/3lysnZkeEeswRZxCHBdd2
         vae46IBUMuPrhA/m6sIKIzqdGOnQo5Ax7q3XOoZhIMO7H4xC0VbFQ0N3vE+qhGQUMHzu
         kPA+f6sp7rqp+TQqvoN2RVgjN8fnA/s8vq6Qc0ND26uA1J32QTIzKCh5QE6EZ2HKVyvQ
         j5NA1EYtTCtaS4iuVqchmK8CE1Gi+C6RcXJmBHwvadsPdAFJPwZbs86of6yw4m2yRstH
         qut3sHXQ3PqToSUKXfBRc1s9T+WqYiB5itYUbgh+khi4BVYb6F2EdusOJNoVl2aI0MUq
         SNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx2+K6b7VucsfYU5uvwShdem3MP0VCFQdKNh537WPsg=;
        b=iAkZucimQUx/FggIT9nUqfitZMPR6SeqhLgOAzw6r3VN/DK7LLO2Vf7EVvkqL5lnbI
         QCJgbD4Uiu56m2EkIQ8ENNJITRhzyrZUHfe0XkpAdnHnDauO9rXY4Nl2vyZ2gPldPIbw
         CFmME1JKAjCAPhQeoTHzf+46AF4jojc8UkRlQxPvhaFRqJHN3sEK4s1TAiSZFKWwTHuc
         Mvm27e1ZXNDA8sRtKtqJsx6uvBVuKytkNFQjKle2fAp+q6uU7bdWsXyU0wjAEotBHnaP
         GwlLLlrCVob48g5ALCWhYcqM8Ymkp8Yi4wTog3NoZAVPPg0qavhtVKa4FXT1ktRRAT84
         QbFg==
X-Gm-Message-State: AO0yUKVlebnZIyrBvb54qvgDLXppOJuyjKQSd+myuCH8a+HRiFoBTbev
        RFuM4TFlHcuXiGvw1oMitF+7mPu3icMmQLoxUQ==
X-Google-Smtp-Source: AK7set8pxVyKhYzeYJbLh/hwRd4Uu3vEs7a87hlm2FvbWgBf9tOHOVoa9Y6GzuIXe4LVFtgGHHuaVLgOE52DzxfEww==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:23d6:b0:625:cf6d:b272 with
 SMTP id g22-20020a056a0023d600b00625cf6db272mr580538pfc.6.1678926678685; Wed,
 15 Mar 2023 17:31:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:30:55 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <75eba82a2666b0caa96ed0484a713037045ed114.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 02/10] KVM: selftests: Test that ftruncate to
 non-page-aligned size on a restrictedmem fd should fail
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/vm/memfd_restricted.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/vm/memfd_restricted.c b/tools/testing/selftests/vm/memfd_restricted.c
index 43a512f273f7..9c4e6a0becbc 100644
--- a/tools/testing/selftests/vm/memfd_restricted.c
+++ b/tools/testing/selftests/vm/memfd_restricted.c
@@ -38,6 +38,11 @@ static void test_file_size(int fd)
 {
 	struct stat sb;
 
+	if (!ftruncate(fd, page_size + 1)) {
+		fail("ftruncate to non page-aligned sizes should fail\n");
+		return;
+	}
+
 	if (ftruncate(fd, page_size)) {
 		fail("ftruncate failed\n");
 		return;
-- 
2.40.0.rc2.332.ga46443480c-goog

