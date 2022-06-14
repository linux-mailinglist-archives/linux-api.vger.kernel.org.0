Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2C54BBC0
	for <lists+linux-api@lfdr.de>; Tue, 14 Jun 2022 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357284AbiFNUX4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jun 2022 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356831AbiFNUXw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jun 2022 16:23:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCF2B262
        for <linux-api@vger.kernel.org>; Tue, 14 Jun 2022 13:23:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f8so8661097plo.9
        for <linux-api@vger.kernel.org>; Tue, 14 Jun 2022 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nd9SDZzw4itSARkNaCG27mmeVq5npYFfTCjzHQFgRI4=;
        b=p6QyLSsT1t1aB5YBfR2GG/BLaAyBd4SBkl0BGT8QMWZSi5jJc3YSPjRemJBh3+V6XA
         KZJATyUOoRYDsVVdw/kIipszAgNMJOgpPU5VatcEX6CEYZ1msrQWV4plcGh7LHLrtnTp
         akv4UMsMNSqOjHw8z8gAkkLexJuuDRkD0al4tVuHcbA4/DRZKLAipfO5H/hck9y5smTW
         jiYxM2MewOBOgmdWfXC/737eDQasC+s2HSxh9bvwM07zN5MWnT2Zz+E+Feg09WHMZxM2
         83HEgL3ospPobrDW66NEE0GE3q3HMv0RpTANPilmJyUZeJf2Jck3uYuBgPD8az//34T/
         Qlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nd9SDZzw4itSARkNaCG27mmeVq5npYFfTCjzHQFgRI4=;
        b=s22bm8iPzPtARVlhaEguAgX2wGhwYIfGsiutP7+9NGAROtAEePz6YPNdcguhUmTKp+
         pSWUHuFLaWs9AcjnGqtWEjgW5cWv2jjQX9K6Cn+m9YSjfH+bRJ7NL4zW0hV6UsFxCP21
         Ypq29To+aBqCjyvZsVAnltkzaVVrdGUceKfImSlp5muKeSD6+N23QITWp2pxv9vZgM/5
         d1QbgVTT2uR/zQyfkeb3sMZH2N91Ut7pyz5KnxVyx4jDFRDj8MKW22khpqvnSzx+ruct
         JBbyR2d33IUzBXDj3/XqzRl0VcJFuEg4Ybi/JAk2d3R2jEw6NQrtSihMGJo4JiTprDJq
         +obw==
X-Gm-Message-State: AJIora86FSW72al1IiPJTJCc4nQ9rp1G9Fwbp+iz+Keun80raWG5O+2u
        9AzCvgAPYEJsNgNt7Ll40EEFzA==
X-Google-Smtp-Source: AGRyM1vX8RWuUdWHsLJEEjO/f7UVrA8nAAcNCbZAKVXVGczleFr3NWAvunxDkB//FhSH2eRR/c3kug==
X-Received: by 2002:a17:90a:728c:b0:1e2:e386:4448 with SMTP id e12-20020a17090a728c00b001e2e3864448mr6258934pjg.167.1655238230059;
        Tue, 14 Jun 2022 13:23:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b00518764d09cdsm7989625pfh.164.2022.06.14.13.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:23:49 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:23:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 3/8] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <YqjuUngpVg8cZTD/@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-4-chao.p.peng@linux.intel.com>
 <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
 <20220601101747.GA1255243@chaop.bj.intel.com>
 <1f1b17e8-a16d-c029-88e0-01f522cc077a@amd.com>
 <20220602100733.GA1296997@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602100733.GA1296997@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 02, 2022, Chao Peng wrote:
> On Wed, Jun 01, 2022 at 02:11:42PM +0200, Gupta, Pankaj wrote:
> > 
> > > > > Introduce a new memfd_create() flag indicating the content of the
> > > > > created memfd is inaccessible from userspace through ordinary MMU
> > > > > access (e.g., read/write/mmap). However, the file content can be
> > > > > accessed via a different mechanism (e.g. KVM MMU) indirectly.
> > > > > 
> > > > 
> > > > SEV, TDX, pkvm and software-only VMs seem to have usecases to set up
> > > > initial guest boot memory with the needed blobs.
> > > > TDX already supports a KVM IOCTL to transfer contents to private
> > > > memory using the TDX module but rest of the implementations will need
> > > > to invent
> > > > a way to do this.
> > > 
> > > There are some discussions in https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2022%2F5%2F9%2F1292&amp;data=05%7C01%7Cpankaj.gupta%40amd.com%7Cb81ef334e2dd44c6143308da43b87d17%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637896756895977587%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oQbM2Hj7GlhJTwnTM%2FPnwsfJlmTL7JR9ULBysAqm6V8%3D&amp;reserved=0
> > > already. I somehow agree with Sean. TDX is using an dedicated ioctl to
> > > copy guest boot memory to private fd so the rest can do that similarly.
> > > The concern is the performance (extra memcpy) but it's trivial since the
> > > initial guest payload is usually optimized in size.
> > > 
> > > > 
> > > > Is there a plan to support a common implementation for either allowing
> > > > initial write access from userspace to private fd or adding a KVM
> > > > IOCTL to transfer contents to such a file,
> > > > as part of this series through future revisions?
> > > 
> > > Indeed, adding pre-boot private memory populating on current design
> > > isn't impossible, but there are still some opens, e.g. how to expose
> > > private fd to userspace for access, pKVM and CC usages may have
> > > different requirements. Before that's well-studied I would tend to not
> > > add that and instead use an ioctl to copy. Whether we need a generic
> > > ioctl or feature-specific ioctl, I don't have strong opinion here.
> > > Current TDX uses a feature-specific ioctl so it's not covered in this
> > > series.
> > 
> > Common function or ioctl to populate preboot private memory actually makes
> > sense.
> > 
> > Sorry, did not follow much of TDX code yet, Is it possible to filter out
> > the current TDX specific ioctl to common function so that it can be used by
> > other technologies?
> 
> TDX code is here:
> https://patchwork.kernel.org/project/kvm/patch/70ed041fd47c1f7571aa259450b3f9244edda48d.1651774250.git.isaku.yamahata@intel.com/
> 
> AFAICS It might be possible to filter that out to a common function. But
> would like to hear from Paolo/Sean for their opinion.

Eh, I wouldn't put too much effort into creating a common helper, I would be very
surprised if TDX and SNP can share a meaningful amount of code that isn't already
shared, e.g. provided by MMU helpers.

The only part I truly care about sharing is whatever ioctl(s) get added, i.e. I
don't want to end up with two ioctls that do the same thing for TDX vs. SNP.
