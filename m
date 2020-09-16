Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3612226BE1A
	for <lists+linux-api@lfdr.de>; Wed, 16 Sep 2020 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIPHfz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Sep 2020 03:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIPHfz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Sep 2020 03:35:55 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC64420684;
        Wed, 16 Sep 2020 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600241753;
        bh=2pPFIyfq0HjxH/I1nQKf+tcVT9qAd8yS6QngBOEx7EM=;
        h=From:To:Cc:Subject:Date:From;
        b=vmdF6YyEB8K43yb24Kg6zm0j4OO0J4YfRQUhda6kxWGSkiiiEYf+hLqZ02CIXPwlM
         Jdr8dbGjeKvbOlyunWXwNBY1AnSuPi1Px8CjQNkSTzaGVLH+Ni/iKzRTu6j/sknoVZ
         k8/99vOci9u79NSkO4xPycClE/DSngY3k0XJOHdA=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: [PATCH v5 0/5] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Wed, 16 Sep 2020 10:35:34 +0300
Message-Id: <20200916073539.3552-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is an implementation of "secret" mappings backed by a file descriptor. 
I've dropped the boot time reservation patch for now as it is not strictly
required for the basic usage and can be easily added later either with or
without CMA.

v5 changes:
* rebase on v5.9-rc5
* drop boot time memory reservation patch

v4 changes:
* rebase on v5.9-rc1
* Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
* Make secret mappings exclusive by default and only require flags to
  memfd_secret() system call for uncached mappings, thanks again Kirill :)

v3 changes:
* Squash kernel-parameters.txt update into the commit that added the
  command line option.
* Make uncached mode explicitly selectable by architectures. For now enable
  it only on x86.

v2 changes:
* Follow Michael's suggestion and name the new system call 'memfd_secret'
* Add kernel-parameters documentation about the boot option
* Fix i386-tinyconfig regression reported by the kbuild bot.
  CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
  from one side and still make it available unconditionally on
  architectures that support SET_DIRECT_MAP.

The file descriptor backing secret memory mappings is created using a
dedicated memfd_secret system call The desired protection mode for the
memory is configured using flags parameter of the system call. The mmap()
of the file descriptor created with memfd_secret() will create a "secret"
memory mapping. The pages in that mapping will be marked as not present in
the direct map and will have desired protection bits set in the user page
table. For instance, current implementation allows uncached mappings.

Although normally Linux userspace mappings are protected from other users, 
such secret mappings are useful for environments where a hostile tenant is
trying to trick the kernel into giving them access to other tenants
mappings.

Additionally, the secret mappings may be used as a mean to protect guest
memory in a virtual machine host.

For demonstration of secret memory usage we've created a userspace library
[1] that does two things: the first is act as a preloader for openssl to
redirect all the OPENSSL_malloc calls to secret memory meaning any secret
keys get automatically protected this way and the other thing it does is
expose the API to the user who needs it. We anticipate that a lot of the
use cases would be like the openssl one: many toolkits that deal with
secret keys already have special handling for the memory to try to give
them greater protection, so this would simply be pluggable into the
toolkits without any need for user application modification.

I've hesitated whether to continue to use new flags to memfd_create() or to
add a new system call and I've decided to use a new system call after I've
started to look into man pages update. There would have been two completely
independent descriptions and I think it would have been very confusing.

Hiding secret memory mappings behind an anonymous file allows (ab)use of
the page cache for tracking pages allocated for the "secret" mappings as
well as using address_space_operations for e.g. page migration callbacks.

The anonymous file may be also used implicitly, like hugetlb files, to
implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
ABIs in the future.

As the fragmentation of the direct map was one of the major concerns raised
during the previous postings, I've added an amortizing cache of PMD-size
pages to each file descriptor that is used as an allocation pool for the
secret memory areas.

v4: https://lore.kernel.org/lkml/20200818141554.13945-1-rppt@kernel.org
v3: https://lore.kernel.org/lkml/20200804095035.18778-1-rppt@kernel.org
v2: https://lore.kernel.org/lkml/20200727162935.31714-1-rppt@kernel.org
v1: https://lore.kernel.org/lkml/20200720092435.17469-1-rppt@kernel.org/
rfc-v2: https://lore.kernel.org/lkml/20200706172051.19465-1-rppt@kernel.org/
rfc-v1: https://lore.kernel.org/lkml/20200130162340.GA14232@rapoport-lnx/


Mike Rapoport (5):
  mm: add definition of PMD_PAGE_ORDER
  mmap: make mlock_future_check() global
  mm: introduce memfd_secret system call to create "secret" memory areas
  arch, mm: wire up memfd_secret system call were relevant
  mm: secretmem: use PMD-size pages to amortize direct map fragmentation

 arch/Kconfig                           |   7 +
 arch/arm64/include/asm/unistd.h        |   2 +-
 arch/arm64/include/asm/unistd32.h      |   2 +
 arch/arm64/include/uapi/asm/unistd.h   |   1 +
 arch/riscv/include/asm/unistd.h        |   1 +
 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/dax.c                               |  11 +-
 include/linux/pgtable.h                |   3 +
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   7 +-
 include/uapi/linux/magic.h             |   1 +
 include/uapi/linux/secretmem.h         |   8 +
 kernel/sys_ni.c                        |   2 +
 mm/Kconfig                             |   4 +
 mm/Makefile                            |   1 +
 mm/internal.h                          |   3 +
 mm/mmap.c                              |   5 +-
 mm/secretmem.c                         | 333 +++++++++++++++++++++++++
 20 files changed, 383 insertions(+), 12 deletions(-)
 create mode 100644 include/uapi/linux/secretmem.h
 create mode 100644 mm/secretmem.c

-- 
2.28.0

