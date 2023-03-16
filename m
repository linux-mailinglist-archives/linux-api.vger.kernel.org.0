Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68326BC2BB
	for <lists+linux-api@lfdr.de>; Thu, 16 Mar 2023 01:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjCPAco (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Mar 2023 20:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjCPAcC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Mar 2023 20:32:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC19EF78
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 17:31:30 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id np13-20020a17090b4c4d00b0023d3f0949d4so61930pjb.6
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K90xoVX+0RlzLAw3SfN8qTyLgxMNh2Rq4fRe4RbG85I=;
        b=d8uc3IApbYmz26P2pZurWd/mdMnPn+5Qfc7rz6kuRm/Rdx7nODA9CSqEzNbHzvos3x
         RveM5uzlBa4alqsey/A+ZQ+F9FkBIhKp+vzmydZ7x8yVdpJ1dFg58aZJtFtCTBrdqTeM
         jtglH5cHaz9xRzfcMN6bC6InRMKXNsMGC/lp63mFpBGrilMy6mUNN3C7pjzFUdepgkuU
         +cgfLXerxqml3OAS1MvZtFFYDjNKV6KkSDelOKwW/Ftb9Njw0KqVRUjV1fgWAjc/PHx5
         vlmTiVMmyjWJKxE37zalK36nTXI7Daq2qNoskHBh/u2Z2VdJEZ3uNpydLhqA1aIDw3qB
         CSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K90xoVX+0RlzLAw3SfN8qTyLgxMNh2Rq4fRe4RbG85I=;
        b=4lM2k3Xeme9wIyV1V4HOSd8BW24XbgM8q9aXGObVbH5EAiusxnocPTupRlmLubRAPV
         o0ylaujZ0w7LdoCHuX4NfTaD68jSZBkk76tNakL8E9qAETvB7rizczffPhm6WgUiUi36
         0PN/OpvoakQ0GPyd6mx0h3bN2Xi//X3Lzf5lSKtxrVuyZWjWu8GAyAuGDZylQCCFHgWe
         EOAx0x68iEV8e2asJg6eIIhOHX2sL+A9ZWfXqCcppxxnxx/PpOMgxx2L++o4gcNynBTu
         8kGvZLZu+wS8m8rtULYjEOOgSc/asTq9r7jUz42pHJqBc2snU8ii0vheus/hoUsslDu/
         gbDw==
X-Gm-Message-State: AO0yUKXmyGlsA4a9Luq99LmJH64AhJte+LXZQS5InOOI+rx6AWwI+sfT
        crJmU020OTdfkwswuq1ryMAQ1e0XkKqYe3C34w==
X-Google-Smtp-Source: AK7set81FNM6aZ2KKc0RpczFG5Lx+WgCWICz/KzlEJw1NjziYveSgQLqdoN474MmozxZF5HPAo3b3AmF9lnSjz983g==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:198d:b0:5a9:9713:1dc with
 SMTP id d13-20020a056a00198d00b005a9971301dcmr677531pfl.6.1678926688561; Wed,
 15 Mar 2023 17:31:28 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:31:01 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <287d6e84dc788d84599392ca5d65864201f9a6a4.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 08/10] KVM: selftests: Default private_mem_conversions_test
 to use 1 restrictedmem file for test data
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

Default the private/shared memory conversion tests to use a single
file (when multiple memslots are requested), while executing on
multiple vCPUs in parallel, to stress-test the restrictedmem subsystem.

Also add a flag to allow multiple files to be used.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86_64/private_mem_conversions_test.c | 52 ++++++++++++++-----
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index afaf8d0e52e6..ca30f0f05c39 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -324,7 +324,8 @@ void *thread_function(void *input)
 }
 
 static void add_memslot_for_vcpu(
-	struct kvm_vm *vm, enum vm_mem_backing_src_type src_type, uint8_t vcpu_id)
+	struct kvm_vm *vm, enum vm_mem_backing_src_type src_type, uint8_t vcpu_id,
+	int restrictedmem_fd, uint64_t restrictedmem_offset)
 {
 	uint64_t gpa = data_gpa_base_for_vcpu_id(vcpu_id);
 	uint32_t slot = DATA_SLOT_BASE + vcpu_id;
@@ -336,7 +337,8 @@ static void add_memslot_for_vcpu(
 
 static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 				 uint8_t nr_vcpus, uint32_t iterations,
-				 bool use_multiple_memslots)
+				 bool use_multiple_memslots,
+				 bool use_different_restrictedmem_files)
 {
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
@@ -356,21 +358,28 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
 	npages_for_all_vcpus = DATA_SIZE / vm->page_size * nr_vcpus;
+	virt_map(vm, DATA_GPA_BASE, DATA_GPA_BASE, npages_for_all_vcpus);
 
 	if (use_multiple_memslots) {
-		for (i = 0; i < nr_vcpus; i++)
-			add_memslot_for_vcpu(vm, src_type, i);
+		int fd = memfd_restricted(0);
+		int offset = 0;
+
+		for (i = 0; i < nr_vcpus; i++) {
+			if (use_different_restrictedmem_files) {
+				if (i > 0)
+					fd = memfd_restricted(0);
+			} else {
+				offset = i * DATA_GPA_SPACING;
+			}
+
+			add_memslot_for_vcpu(vm, src_type, i, fd, offset);
+		}
 	} else {
 		vm_userspace_mem_region_add(
 			vm, src_type, DATA_GPA_BASE, DATA_SLOT_BASE,
 			npages_for_all_vcpus, KVM_MEM_PRIVATE);
 	}
 
-	virt_map(vm, DATA_GPA_BASE, DATA_GPA_BASE, npages_for_all_vcpus);
-
-	for (i = 0; i < nr_vcpus; i++)
-		add_memslot_for_vcpu(vm, src_type, i);
-
 	for (i = 0; i < nr_vcpus; i++) {
 		args[i].vm = vm;
 		args[i].vcpu = vcpus[i];
@@ -382,7 +391,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_join(threads[i], NULL);
 
-	if (!use_multiple_memslots)
+	if (!use_multiple_memslots || !use_different_restrictedmem_files)
 		test_invalidation_code_unbound(vm, 1, DATA_SIZE * nr_vcpus);
 	else
 		test_invalidation_code_unbound(vm, nr_vcpus, DATA_SIZE);
@@ -391,8 +400,9 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
 static void usage(const char *command)
 {
 	puts("");
-	printf("usage: %s [-h] [-m] [-s mem-type] [-n number-of-vcpus] [-i number-of-iterations]\n",
-	       command);
+	printf("usage: %s\n", command);
+	printf("       [-h] [-m] [-f] [-s mem-type]\n");
+	printf("       [-n number-of-vcpus] [-i number-of-iterations]\n");
 	puts("");
 	backing_src_help("-s");
 	puts("");
@@ -404,6 +414,9 @@ static void usage(const char *command)
 	puts("");
 	puts(" -m: use multiple memslots (default: use 1 memslot)");
 	puts("");
+	puts(" -f: use different restrictedmem files for each memslot");
+	puts("     (default: use 1 restrictedmem file for all memslots)");
+	puts("");
 }
 
 int main(int argc, char *argv[])
@@ -412,12 +425,13 @@ int main(int argc, char *argv[])
 	uint8_t nr_vcpus = 2;
 	uint32_t iterations = 10;
 	bool use_multiple_memslots = false;
+	bool use_different_restrictedmem_files = false;
 	int opt;
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXIT_HYPERCALL));
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "mhs:n:i:")) != -1) {
+	while ((opt = getopt(argc, argv, "fmhs:n:i:")) != -1) {
 		switch (opt) {
 		case 'n':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
@@ -431,6 +445,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			use_multiple_memslots = true;
 			break;
+		case 'f':
+			use_different_restrictedmem_files = true;
+			break;
 		case 'h':
 		default:
 			usage(argv[0]);
@@ -438,6 +455,13 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	test_mem_conversions(src_type, nr_vcpus, iterations, use_multiple_memslots);
+	if (!use_multiple_memslots && use_different_restrictedmem_files) {
+		printf("Overriding -f flag: ");
+		puts("Using just 1 restrictedmem file since only 1 memslot is to be used.");
+		use_different_restrictedmem_files = false;
+	}
+
+	test_mem_conversions(src_type, nr_vcpus, iterations, use_multiple_memslots,
+			     use_different_restrictedmem_files);
 	return 0;
 }
-- 
2.40.0.rc2.332.ga46443480c-goog

