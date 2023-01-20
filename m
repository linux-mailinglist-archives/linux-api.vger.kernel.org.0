Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07E6675DD9
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 20:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjATTUU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Jan 2023 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjATTUT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Jan 2023 14:20:19 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32057AF06
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 11:20:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i1so4729976pfk.3
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGyt6CUdmtm2ioRKnF8I31iR5Kv2QPHBMLPFSaYDNiY=;
        b=Uu5CA7ojWufnZge0bmJujGF0GkpDKBVBcpU8xWM4Q0rxz/aT0RAyOpA1DHBDMPbVFN
         tqUjNMfa3Aif+GgOpT8Q+nf25/sXFy7XS5A1bpe7NXC9AG09PWDFNgVwd3N4AL4mEvjv
         uK6rJDTix7y5/wRAdoMLSZqftlfVqyVo6OkYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGyt6CUdmtm2ioRKnF8I31iR5Kv2QPHBMLPFSaYDNiY=;
        b=hScxS3iPGuiDgSvbxkLFjk95A1RS8f4TFZ9YpErXeRBYR7hlg0lgqUpqR8ZWbwYubL
         bUAasjKuPhOOOkh7F6B0REZMcIsVY9Wred57b6Su+a/Wii3MudTVTN5fGjqFq89Igg3c
         p1SWHV9cuqKMDa+6SaD+wiiNsSQe91mjjXRnM2nhaT6mIe3t5LYM0ObeG551BZZaZn4+
         RF+va0lpAJk6/Cpg0BwIQ2ssofJzdVNK7yAMs+G2cQEOND6sA1IeTkCx84S+eBhqZpCw
         7aPp3Y0A3jtEP/xeBa/G+13KX4yQkoCZlNL376Bvz2xCtt6FItgj/IAwcvNqxWj4X6Vx
         sEAg==
X-Gm-Message-State: AFqh2kqtb5TVI0PnPe599m1r2njhzLfNF/e5MU6v1GNLjG85m1YWAUnV
        g46acVsqBdmRF8EAYdp+uUTGTw==
X-Google-Smtp-Source: AMrXdXuyTIAN7HmAtV4HD1P3My5ps1sTBJQbBVFpT8W/R685exOGUTBZBi+w0yjPJR+F6KcbCZ6lsg==
X-Received: by 2002:a05:6a00:3025:b0:58d:a683:bb2f with SMTP id ay37-20020a056a00302500b0058da683bb2fmr18456253pfb.23.1674242417297;
        Fri, 20 Jan 2023 11:20:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3-20020a621503000000b00581c741f95csm24490646pfv.46.2023.01.20.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:19:50 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:19:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 00/39] Shadow stacks for userspace
Message-ID: <202301201118.6A55DE336@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119142602.97b24f3cdba75f20f97786d3@linux-foundation.org>
 <b6d88208b987c9cbbdb194b344d2a537dbd76914.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d88208b987c9cbbdb194b344d2a537dbd76914.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 20, 2023 at 05:27:30PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2023-01-19 at 14:26 -0800, Andrew Morton wrote:
> > On Thu, 19 Jan 2023 13:22:38 -0800 Rick Edgecombe <
> > rick.p.edgecombe@intel.com> wrote:
> > 
> > > SHSTK
> > 
> > Sounds like me trying to swear in Russian while drunk.
> > 
> > Is there any chance of s/shstk/shadow_stack/g?
> 
> I'm fine with the name change. I think shstk got debated and picked
> early in the history of the series before I got involved. "shstk" is
> nice and short, but it's not completely clear what it is unless you
> already know about shadow stack. So there is a tradeoff of clarity and
> line length/wrapping. Does anyone else have any strong opinions?

I prefer SHSTK because it specifically means x86's hardware shadow
stack from CET. Lots of things can (and have) implemented things called
"shadow stack".

-- 
Kees Cook
