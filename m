Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E7C5F3BEA
	for <lists+linux-api@lfdr.de>; Tue,  4 Oct 2022 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJDD7L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 23:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJDD7J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 23:59:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D35402FE
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 20:59:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so698294pjs.0
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=6ZXZFqW1zvCEoHZIgPOM5DbWMEQFUkDUHhmwfnnqfck=;
        b=M06N2WAnCq6ae00Dt1ENQITbBcoMx6NqoCSc7aGK2zRr09KbTJuXqJ7I6KBSXpeouq
         WlPVfOqBFfWxcUNfCQleD0l3vdGcnc2mgsI/jkhnq1r94kJku4kfV2O+E/Ac3FdCrgST
         1GLcCVgfuKoNNA0mDgizAkNa8H7zCCMkkVtA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6ZXZFqW1zvCEoHZIgPOM5DbWMEQFUkDUHhmwfnnqfck=;
        b=GFg6Du6LH9tRUcBC7baPbvbfC4DDt7/dtBSl8jtqoLu4V7+53g2PseEgxH75G8g9A1
         euHtljRWso1xox6WDE91bifW/xChQLDAl7I9INBDdrMWPDWKZ6IgZIJz4dg7UZmy0ArP
         yb6EtogKjyWW2Pk2RW1btd6qyNik4kP8PmtMCLaWi0x0sDSQ9mOcaUHArYHSqG4ldUDc
         UWEJ5YBBqNO4Kd1CU4jKYn0kfCUin53DCZ0RyNJZ8n5ZxxblqWBb3qKHcFdAu1CRE8en
         ePwP+zL94dyDIQNdC+BwRpeMAWkf4cnGbmADdGwFSvW4r4r5S3OVq5Jq/Rh4G091zQFP
         L/mQ==
X-Gm-Message-State: ACrzQf1WWINeoGxTFrCEATSHUVyFV+YIsX1kbnIpzxhDe79BPGYkg2H5
        N9KptXVAH5iDSH9kseVlmkpWpA==
X-Google-Smtp-Source: AMsMyM50Foz8ANOtkKfZBNm5Ztw8tPSpl+z4P2LOSKo520ZEeaXLe42fyqEuBCWyfUwPzX1G0DOZwQ==
X-Received: by 2002:a17:902:7009:b0:178:b9c9:979f with SMTP id y9-20020a170902700900b00178b9c9979fmr24273802plk.39.1664855946656;
        Mon, 03 Oct 2022 20:59:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h19-20020a656393000000b0042c0ffa0e62sm7543842pgv.47.2022.10.03.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 20:59:05 -0700 (PDT)
Date:   Mon, 3 Oct 2022 20:59:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 00/39] Shadowstacks for userspace
Message-ID: <202210032058.D17B1A3@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <202210030946.CB90B94C11@keescook>
 <7c85acd79688c5ea41f760535612ef77093a41c7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c85acd79688c5ea41f760535612ef77093a41c7.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 03, 2022 at 06:33:52PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2022-10-03 at 10:04 -0700, Kees Cook wrote:
> > > Shadow stack signal format
> > > --------------------------
> > > So to handle alt shadow stacks we need to push some data onto a
> > > stack. To 
> > > prevent SROP we need to push something to the shadow stack that the
> > > kernel can 
> > > [...]
> > > shadow stack return address or a shadow stack tokens. To make sure
> > > it can’t be 
> > > used, data is pushed with the high bit (bit 63) set. This bit is a
> > > linear 
> > > address bit in both the token format and a normal return address,
> > > so it should 
> > > not conflict with anything. It puts any return address in the
> > > kernel half of 
> > > the address space, so would never be created naturally by a
> > > userspace program. 
> > > It will not be a valid restore token either, as the kernel address
> > > will never 
> > > be pointing to the previous frame in the shadow stack.
> > > 
> > > When a signal hits, the format pushed to the stack that is handling
> > > the signal 
> > > is four 8 byte values (since we are 64 bit only):
> > > > 1...old SSP|1...alt stack size|1...alt stack base|0|
> > 
> > Do these end up being non-canonical addresses? (To avoid confusion
> > with
> > "real" kernel addresses?)
> 
> Usually, but not necessarily with LAM. LAM cannot mask bit 63 though.
> So hypothetically they could become "real" kernel addresses some day.
> To keep them in the user half but still make sure they are not usable,
> you would either have to encode the bits over a lot of entries which
> would use extra space, or shrink the available address space, which
> could cause compatibility problems.
> 
> Do you think it's an issue?

Nah; I think it's a good solution. I was just trying to make sure I
understood it correctly. Thanks!

-- 
Kees Cook
