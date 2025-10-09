Return-Path: <linux-api+bounces-5054-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9AEBCB29B
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 00:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3D13B5341
	for <lists+linux-api@lfdr.de>; Thu,  9 Oct 2025 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431272877D7;
	Thu,  9 Oct 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq0yYHh8"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508D28151E
	for <linux-api@vger.kernel.org>; Thu,  9 Oct 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050682; cv=none; b=lcR+nG/MbCopWfZCEXvJteXP2vTihdeyP7bT0IfDyMdCPQGOzsob6QNTaFfDSCuVnFO7IeZGEpLtf0EnRC7ITX5l89+vEsZePoem96QKKhknHRxC9Ks72BmvEJQOcwtOg7Xk6iB7Qan0pkAIHC5BCYSpDtCdIG/OtQNycFjjNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050682; c=relaxed/simple;
	bh=9fvxDpiBJ75A3YF7/Lpzvf3cCPTSGdgJtsV2MXaYEU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se4AzkN4nkpcRuHv56KyHW5oLYIKPPlTcQlkvBA78WymDwYZLwZnXhK/kmFrMzTXujXrsGfqEL+vTE6DCSDgQChE0D3gzjXfuiINE4iZaD9Yz8eeMx4r7TsQ4R1QA0H+DWatevK8twU/dsW3wuPlRYuhC6TDyYW60kf2zJcZvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eq0yYHh8; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2731ff54949so40615ad.1
        for <linux-api@vger.kernel.org>; Thu, 09 Oct 2025 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760050680; x=1760655480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TS3X0oB2KcD5loH5VjDML1tNfmcYzwsUaHGn/yfIcO4=;
        b=eq0yYHh8GCD6TuDTvYXVRF2V1WW5ACIca66VVTBUniJU/lX6jY9dJwlzTj5aNyjrrK
         fd/Dh1llyPZ2mr/8RPyS/QyQEmM2/V1cP90N7pwsAEGYw7DQ57Z+mXmWGyWeSWDjTiOc
         sECefijEJKFFPYc5rHgMAlAzcMrc3SJu86yZI/E48dgipgbJCFD9ZNjZAUv7Fm+97EYr
         mLbYoljq7Le7v3JZubYOwOdRtfTKxP4YosWxw5xMYbInDq3/u2aDp4r/bzScbAsP+Qj/
         l2N5TEOXvnzr8Lxqxiuzuji1lRXpipiX+xEJw5QkCOhMWY27Pkt4i2e3wYHOjraX3890
         oUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050680; x=1760655480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS3X0oB2KcD5loH5VjDML1tNfmcYzwsUaHGn/yfIcO4=;
        b=XWwAQ0iN0AedjWxaEv8ib0Se0khGynRlE/eUXxnKXfiBP4kc2KuN0Xgd/UUDVgKpk4
         tziucnmFEEGBGLLm1xwzTmeVeI76txxxdZTqAwSYMGhINBYCgaBJfaoapgtIdTNLA7E4
         2s70pLWt4bXfmOgiwFPojxMdBqxtNA4fnxhJIV56qowigyeW9Gc2a2x14iTcs0l49Ky+
         p8cDKmFgt7XoMCR/Z56vbBgonhcFugqy2iFxpNhvJ7yK26XcELnbPKZo8oUEMnrQYLSL
         IiGSkzpcV9IGD2pXCzI/ScS/caMAAFFkfrQM0NFlvyjbuTe8CbREKFYDI20qAMp8IUTc
         WIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeELxijgqvqHhXVtSzQycIj76KXWz392kRwKh2rTehFTJXPIL3Tu0hd75lvFTUe64BdF9/ne/+3HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjMTNFwC7lx9UQDR1YKDxjOxl6xcGO9tL+UuqHxB2aIxzKH2jx
	Ok72lo4qzqZycJSqC3yb1JPG+Avz+D8cbhWgCyv6qI/9uGwEm+rGyYstGvgb70AUZQ==
X-Gm-Gg: ASbGnctoKnTXWolBROCmD2ZtZAFeyJGY47j2V0jzdp1Cr1xSVEEyEQXslJnX38tN6t6
	DpmAcQo3hYA+UjsRUq1yhlxi6IqAy6BYbKz55N/Hhn5n6eb+oAFUAjOs/y6buE9G5u/Ufe9yy6v
	MYTgHJFAcTGFc4IuZuoB4OXKgQb4TLhEvLjYjw7cprBJ5GYJFHEAL1aWhnSv8LOUIAnNyxyyteU
	Z3EyBWGqTxAFb3sP5OozY4KJwKBvstXIipsrnwxNRhT1NrMeq9D+wQipVDYIEJrA7RLAeNfuapZ
	1ZTaU/zPYBcoJCqIcNTSZTY5fRAVtyDUmuaLAS0fGc1Ph2wvbFR54m6i7lUAI++52LccY4bb6pA
	F1fUJBKcyB7OOyqVjV1mjfDk1IWdnEayx+MDenbWIpgifgD47E4dO/awbbglvMdhUIyfM7VlYyQ
	3Ypg2SN+l4ILg=
X-Google-Smtp-Source: AGHT+IEUelxecU4Ltxm3QGl/GGQDXbTCrG57RujR1Y9rUZidwWpY6H+v0tk5x12Foy4wJMi0lrd0zA==
X-Received: by 2002:a17:902:ce06:b0:269:63ea:6d3f with SMTP id d9443c01a7336-29027613a04mr13422595ad.8.1760050679106;
        Thu, 09 Oct 2025 15:57:59 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b252f23sm847400b3a.6.2025.10.09.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:58 -0700 (PDT)
Date: Thu, 9 Oct 2025 15:57:48 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 26/30] selftests/liveupdate: Add multi-kexec session
 lifecycle test
Message-ID: <20251009225748.GA2098969.vipinsh@google.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-27-pasha.tatashin@soleen.com>
 <20251003225120.GA2035091.vipinsh@google.com>
 <CA+CK2bBuO5YaL8MNqb5Xo_us600vTe2SF_yMNU-O9D2_RBoMag@mail.gmail.com>
 <CA+CK2bBSObHG=9Rj623mahyhE81DhhKbN09aHS96p==8y_mCGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBSObHG=9Rj623mahyhE81DhhKbN09aHS96p==8y_mCGw@mail.gmail.com>

On 2025-10-03 22:37:10, Pasha Tatashin wrote:
> > > > --- a/tools/testing/selftests/liveupdate/Makefile
> > > > +++ b/tools/testing/selftests/liveupdate/Makefile
> > > > @@ -1,7 +1,38 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +KHDR_INCLUDES ?= -I../../../usr/include
> > >
> > > If make is run from the tools/testing/selftests/liveupdate directory, this
> > > will not work because it needs one more "..".

This causes a build issue, see my response at the bottom.

> > >
> > > If this is built using selftest Makefile from root directory
> > >
> > >   make -C tools/testing/selftests TARGETS=liveupdate
> > >
> > > there will not be build errors because tools/testing/selftests/Makefile
> > > defines KHDR_INCLUDES, so above definition will never happen.
> > >

If one is just building test using the above make command (without
install) we don't see other liveupdate test binaries.

> > > > +# --- Test Configuration (Edit this section when adding new tests) ---
> > > > +LUO_SHARED_SRCS := luo_test_utils.c
> > > > +LUO_SHARED_HDRS += luo_test_utils.h
> > > > +
> > > > +LUO_MANUAL_TESTS += luo_multi_kexec
> > > > +
> > > > +TEST_FILES += do_kexec.sh
> > > >
> > > >  TEST_GEN_PROGS += liveupdate
> > > >
> > > > +# --- Automatic Rule Generation (Do not edit below) ---
> > > > +
> > > > +TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
> > > > +
> > > > +# Define the full list of sources for each manual test.
> > > > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > > > +     $(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
> > > > +
> > > > +# This loop automatically generates an explicit build rule for each manual test.
> > > > +# It includes dependencies on the shared headers and makes the output
> > > > +# executable.
> > > > +# Note the use of '$$' to escape automatic variables for the 'eval' command.
> > > > +$(foreach test,$(LUO_MANUAL_TESTS), \
> > > > +     $(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
> > > > +             $(call msg,LINK,,$$@) ; \
> > > > +             $(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
> > > > +             $(Q)chmod +x $$@ \
> > > > +     ) \
> > > > +)
> > > > +
> > > >  include ../lib.mk
> > >
> > > make is not building LUO_MANUAL_TESTS, it is only building liveupdate.
> > > How to build them?
> >
> > I am building them out of tree:
> > make O=x86_64 -s -C tools/testing/selftests TARGETS=liveupdate install
> > make O=x86_64 -s -C tools/testing/selftests TARGETS=kho install
> 
> Actually, I just tested in-tree and everything works for me, could you
> please verify:
> 
> make mrproper  # Clean the tree
> cat tools/testing/selftests/liveupdate/config > .config # Copy LUO depends.
> make olddefconfig  # make a def config with LUO
> make kvm_guest.config # Build minimal KVM guest with LUO
> make headers # Make uAPI headers
> make -C tools/testing/selftests TARGETS=liveupdate install # make and
> install liveupdate selftests

Yes, this one builds the tests.

However, if instead of using the above make command, we do

  cd tools/testing/selftests/liveupdate
  make

This will error out

    LINK     liveupdate
  liveupdate.c:19:10: fatal error: linux/liveupdate.h: No such file or directory
     19 | #include <linux/liveupdate.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  In file included from luo_test_utils.c:21:
  luo_test_utils.h:13:10: fatal error: linux/liveupdate.h: No such file or directory
     13 | #include <linux/liveupdate.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
  In file included from <command-line>:
  /usr/include/stdc-predef.h:1: fatal error: cannot create precompiled header /liveupdate: Permission denied
      1 | /* Copyright (C) 1991-2025 Free Software Foundation, Inc.
  compilation terminated.
  make: *** [Makefile:30: /liveupdate] Error 1

Reason for this build error is KHDR_INCLUDES in the selftest/liveupdate/Makefile

Following fix resolves this above two "No such file or directory" error.

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 25a6dec790bb..6507682addac 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only

-KHDR_INCLUDES ?= -I../../../usr/include
+KHDR_INCLUDES ?= -I../../../../usr/include
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 LDFLAGS += -static

My git diff in the first response fixes build issue and generate tests.
https://lore.kernel.org/linux-mm/20251003225120.GA2035091.vipinsh@google.com/

I am used to kvm and vfio selftests. They both build all their binaries
by running 'make' from their directories. That's why I found it odd that
liveupdate is behaving differently.


