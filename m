Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862FE6374F3
	for <lists+linux-api@lfdr.de>; Thu, 24 Nov 2022 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiKXJTY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Nov 2022 04:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKXJTX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Nov 2022 04:19:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B4113FC8
        for <linux-api@vger.kernel.org>; Thu, 24 Nov 2022 01:19:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso796853wmo.1
        for <linux-api@vger.kernel.org>; Thu, 24 Nov 2022 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21RtI83U3AWt3cyeCJ2XmHc2ruDDyw09Go561vbFieg=;
        b=7q/OaKPtQ4IeYxQHQaC4aOn7zrvJ3Yr8RQyWvwQwcRu0jouQ1mzKgLwVH1+4CtBlT0
         WqqJ97pJd1e6ipFHKwm0vRnNnfYpGlLhc2UVYB6Y3U09PlrX4FMMxevbcWyLBOcWWvdL
         YPv7ecnuSiy00N+7f+ChYRhSk6+HTph4f7mDMJbWkd6ugWorOzKjS6YqG0JAZHmStWk9
         LcfhTIxE312OlgUaD+s8Rvw/FR0tfahl+821ZbxKeb7qg4IZqU93u76IUVMvn9sRUgy/
         C7aBU3zL62yibHNI9wYEf0E3JQhpAIlj8kMyT9+IlFD31olty3dqCnVlvD1G4WzsbGzJ
         Ccgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21RtI83U3AWt3cyeCJ2XmHc2ruDDyw09Go561vbFieg=;
        b=gJi5+T/7kCIE+6+I7mJc4UzcxgI+sPziPcqkLPGi9KKXhk27NASVgmpkVCW++wA2Iy
         Jr2ztGiscySbUR6CicAJuDVulvf7NKLVUH4uQZMVc/6ExaoW33/eDdPwdXRUgQRBTAl9
         /zwFXo1+UWI+yQ3QAMrfuQ2+fbdEIcon9Ew8p7g7t4F4/HJ1oMA4AStPY8rYXwHQ9oVE
         X9RkWJmxe6w8hR185fmm7u194MFQFLWhbaX57VBWimegJvfeuFjbSaFadj+LpWmTXwHe
         mw07FJX8qJQh9slGWZU4IUbLkmEffqehOflUzLRRJYaEkewkWP1o31EM49vxsm72brE/
         O24Q==
X-Gm-Message-State: ANoB5pkQyzyMgmXUr662o0xqko7pSCz2f0LCmM2WY+G/UEalwkKs7nwd
        0yFznlZdVwL5EqVmBm+YwUPjxw==
X-Google-Smtp-Source: AA0mqf44COThVTh8STo2F/PdfE1hAhOPrq1SYQrMQOFcuboOXsdNStHJxfmCn7TEZsRRJCXahEuHCw==
X-Received: by 2002:a05:600c:3b04:b0:3cf:6fd8:95a4 with SMTP id m4-20020a05600c3b0400b003cf6fd895a4mr22693692wms.73.1669281560664;
        Thu, 24 Nov 2022 01:19:20 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id b10-20020adfde0a000000b0022e57e66824sm898859wrm.99.2022.11.24.01.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:19:20 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:19:16 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: Re: [PATCH v3 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <Y383FE6/w2sLd4I5@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0aSngjI0Hc5d4@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqY0aSngjI0Hc5d4@Sun>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On Mon, Jun 13, 2022 at 02:46:01AM +0800, Hongren (Zenithal) Zheng wrote:
> This patch parses Zb/Zk related string from DT and
> output them in cpuinfo
> 
> One thing worth noting is that if DT provides zk,
> all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> 
> Note that zk is a valid extension name and the current
> DT binding spec allows this.
> 
> This patch also changes the logical id of
> existing multi-letter extensions and adds a statement
> that instead of logical id compatibility, the order
> is needed.
> 
> There currently lacks a mechanism to merge them when
> producing cpuinfo. Namely if you provide a riscv,isa
> "rv64imafdc_zk_zks", the cpuinfo output would be
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> _zksh_zkt"
> 
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
FWIW, after some rebasing:

Tested-by: Samuel Ortiz <sameo@rivosinc.com>

Cheers,
Samuel.
