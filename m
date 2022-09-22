Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB95E6BF8
	for <lists+linux-api@lfdr.de>; Thu, 22 Sep 2022 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiIVTtZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiIVTtX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 15:49:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E710BB39
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 12:49:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y11so10848522pjv.4
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AOIMXA4PI9BYXrk6/Ja2mOKlrFIROrj5K/ieUQQwXS4=;
        b=h1quGJbzNcYbvksztMmJbAj4021+BcmdngI9oVLKqryAXjZOZrGY+bZOFcLzMWlozZ
         LAcA23Adi1Jic4pRnJCptlWTG4EcoRJkXHfvedp0K1HaJOCXyEXxuhzgdof/jPIDOZEe
         ebqjyLF5ANcpzYiinKi6eaQnqth3W4n2V8+InjN4EWNaK7npJ/bYc7FhRS+iyNb4HHPb
         Efk7QXZ7wTcSNyFHTH7NWGDPMQ4YLD125sVU1j3HVB2TkIAvgthLngw1wMrAfORH5ZfR
         U8+tmRxUsuSWAVFhBHQcUHbhvue7DyoPTDpJKMkc7xktoeaZV8RiJlYUMocHTDHlXZyf
         XJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AOIMXA4PI9BYXrk6/Ja2mOKlrFIROrj5K/ieUQQwXS4=;
        b=qbudPiKE4h2H3XfHNVqHtpLGunzUcDpZ8povCnLMfkZETR+JubzsZaqMIlb2FnU5T9
         DHUtOYE/3qrjnA90pffVmuWEKT76AlxlXYw7Pkc5JShV1pgn1S7qO/gVo/k3V+LbKnB1
         Vt4nL1X0uKVfj+sIujoeeI2MWQffoQerEIx45GNXD8QbStS42FTQdVVKE8Vmx9SqlXos
         0rEIWnTskdNI4q0iXoiJcjj9Kztn0MYewdBbKNDW/y/fDdxx4hYng+8dkLZE0qm36LEW
         gqfQ74wxKuEzyr7A3S8IxkcOyTd4qBqZPuTyt8mAJd8Caeoulm1JBj/MHM9WPC0ykOqi
         oXzw==
X-Gm-Message-State: ACrzQf2DoIVx8x3s3XMhvTPav/jAfCehmUV3bXkLPUlyrXO87DnaVl5A
        6lJzzyqZ3f6WfkifNTzLULLIeQ==
X-Google-Smtp-Source: AMsMyM7xkIpUg/GEtYg3CdJDso/M2NS+vljJqn+Iz/Og0ecRlPYRkH7bufKUsfNRGuIjAMJq7OVhXg==
X-Received: by 2002:a17:90a:644e:b0:200:422c:6b1 with SMTP id y14-20020a17090a644e00b00200422c06b1mr5394594pjm.183.1663876162098;
        Thu, 22 Sep 2022 12:49:22 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b00172897952a0sm4576315plh.283.2022.09.22.12.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:49:21 -0700 (PDT)
Date:   Thu, 22 Sep 2022 19:49:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <Yyy8Pp0Y4NRzIzNw@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <DS0PR11MB63734D4DF4C4F368805EC97DDC4E9@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB63734D4DF4C4F368805EC97DDC4E9@DS0PR11MB6373.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 22, 2022, Wang, Wei W wrote:
> On Thursday, September 15, 2022 10:29 PM, Chao Peng wrote:
> > +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> > +			 int *order)
> 
> Better to remove "order" from this interface?

Hard 'no'.

> Some callers only need to get pfn, and no need to bother with
> defining and inputting something unused. For callers who need the "order",
> can easily get it via thp_order(pfn_to_page(pfn)) on their own.

That requires (a) assuming the pfn is backed by struct page, and (b) assuming the
struct page is a transparent huge page.  That might be true for the current
implementation, but it most certainly will not always be true.

KVM originally did things like this, where there was dedicated code for THP vs.
HugeTLB, and it was a mess.  The goal here is very much to avoid repeating those
mistakes.  Have the backing store _tell_ KVM how big the mapping is, don't force
KVM to rediscover the info on its own.
