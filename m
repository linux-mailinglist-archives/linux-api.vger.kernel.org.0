Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4226607BF6
	for <lists+linux-api@lfdr.de>; Fri, 21 Oct 2022 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJUQSV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Oct 2022 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJUQSU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Oct 2022 12:18:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D862514F5
        for <linux-api@vger.kernel.org>; Fri, 21 Oct 2022 09:18:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 10so2838563pli.0
        for <linux-api@vger.kernel.org>; Fri, 21 Oct 2022 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIRb6+ovxp5J4uJ1hVDeWHpfyBDCzaaTh1iPpdxBBXo=;
        b=LBbRjb9HoKMsM0BrB5Yx8EKkNw2z2slGB6RREjreEOgAz6cf4w0roEfiOfI1ISkxC3
         umCpqoYJ+BxiTeH6mDoFf2MIPMRAa8KHajTmAG5q0NIMZtDgJyPYDAp4OEAVmIJyfonP
         YVdGEHCQT54p0r2x+JlsthZbC8pGVdj+LT/dxHs3Utvt9tNW6l/hE2qLrAwkHAoOVZeH
         cqWWQ1T7dnKxpoX4VIogeOoRSjB+ibtFx6bQv9mAbDdRyNK9AcGDi4qG7P8xM/rtcTeQ
         giQByT9/HXaV3sGzuy8Kux9ZJVNncssFk2zzM8JEHArzX1QytiIWnjlmf1c2NjGzQeqm
         YCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIRb6+ovxp5J4uJ1hVDeWHpfyBDCzaaTh1iPpdxBBXo=;
        b=ZlLcoUSpDwpAu+yFEtvtqGH+XcO3ZGDmZ7ZM+mrmV7mCtwYR6469jLyBTwOnv+7ywi
         8UD4q9Aqb8KGGOHUfMMOfaOZ3guuOvBq7SHAP3czpRMX9PcYi2T8KTVtORYGTafd/ong
         ZMImUCh3UIQpakDW4m59MHLQ8wpL6jonwlHtToegCkJIsSotON1ZWobVd4nyS7Rt8yJt
         1IinTg7YM80NXsmUH7xWB6C+cVsygY/mGCOpOp24uqbk262UUPK7DXJTjHdD0Hin765j
         md8bc5DQk8WJlzKjj3w24Xmd/J2Z7Ez7Q5hFXTDcfDDFBKhxDmnVVNXJpkKUIrfTgZVx
         LsoA==
X-Gm-Message-State: ACrzQf0WqnZBlUvsvLaZbkz7NvMoJL/ACgfkGIz0JC5Fbk0HvMjJ+xCj
        S7smrG5Yk5qdFK4giGZDayW9/g==
X-Google-Smtp-Source: AMsMyM7vsZ30ExGufg/GPlnIb76AAev1l4p5ZYo9iokYaR6mEcu4bpMFXgiNWD7ik43HxyivyjTj/A==
X-Received: by 2002:a17:903:50e:b0:182:631b:df6f with SMTP id jn14-20020a170903050e00b00182631bdf6fmr20228449plb.66.1666369098415;
        Fri, 21 Oct 2022 09:18:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b0017f61576dbesm14948739plr.304.2022.10.21.09.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:18:17 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:18:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <Y1LGRvVaWwHS+Zna@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <CAGtprH_MiCxT2xSxD2UrM4M+ghL0V=XEZzEX4Fo5wQKV4fAL4w@mail.gmail.com>
 <20221021134711.GA3607894@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021134711.GA3607894@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 21, 2022, Chao Peng wrote:
> > 
> > In the context of userspace inaccessible memfd, what would be a
> > suggested way to enforce NUMA memory policy for physical memory
> > allocation? mbind[1] won't work here in absence of virtual address
> > range.
> 
> How about set_mempolicy():
> https://www.man7.org/linux/man-pages/man2/set_mempolicy.2.html

Andy Lutomirski brought this up in an off-list discussion way back when the whole
private-fd thing was first being proposed.

  : The current Linux NUMA APIs (mbind, move_pages) work on virtual addresses.  If
  : we want to support them for TDX private memory, we either need TDX private
  : memory to have an HVA or we need file-based equivalents. Arguably we should add
  : fmove_pages and fbind syscalls anyway, since the current API is quite awkward
  : even for tools like numactl.
