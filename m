Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82C551779
	for <lists+linux-api@lfdr.de>; Mon, 20 Jun 2022 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiFTLcs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jun 2022 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiFTLcp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jun 2022 07:32:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F01165B6
        for <linux-api@vger.kernel.org>; Mon, 20 Jun 2022 04:32:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a29so16782178lfk.2
        for <linux-api@vger.kernel.org>; Mon, 20 Jun 2022 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIMgUbT+sdDDCNglVtIeEpzvKHWn5FNbAyBHXWpSN1c=;
        b=PLaJ/ay/YVqFpYPY2jfh6O1y+IIKjBmkQHUC5UeiT6DNhvyULiVcJ6r+KwY4WrG/Ci
         qq8+ZTHG2Y8zjtWSdGPW+grBbRTv+aE+3KI01rDtyDjtgo+HN9iVZzz1B3FdV5uBHppw
         iAJza80SEAUdWj5Hbiw8UfN6MmWGZr+rh9TXiPCYY82KkxjTNea2viH9ZCh6XhqXWLep
         yUOkRfBaQovrA9wObEEHJ/pg0BT7sSX+OTWHxMfC8WAYFTaY2ZzDH546o0yh4xvi7uqp
         waLvS70Mp7MZgx5OcEhVqIOXNX9GPcICgMXHTjWwFvwanesqylxLgKgrmwlGhZFjCNow
         c/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIMgUbT+sdDDCNglVtIeEpzvKHWn5FNbAyBHXWpSN1c=;
        b=N3lo8aueehga45aJey508EDS/BSMUgg7Qoin0/lq2Nt0GQaLFjuoJAtBTh1KEFtSMh
         RbQ1BZFCoh9Sd1A7qVZqMbUEXN7YcEXIe5tRp/98Z7ycGJpgksrfElydsjL6wMNXfUO1
         6sl9mDwzXHaAj1kAdYWtBJSCpb4E/PtxD1aFNXGhS+Hu8smdtSLZT3gg38yRD8IkxlaK
         /UGgzFgHdh//5V6uaoyaWgzrI69mtFeMA3wsDQrfyazti7NYDLj01LPWlVQ3SLhgz93d
         8aBndOjxJadi9/0m34wjIi4gzVcZYeEBubX2rlCkF3ih3sOc+zLxuiJme4LI5r9mgCXQ
         Vxqw==
X-Gm-Message-State: AJIora8VjsTrfHvPuNW38mLPVrQzTR9p9mnZLgjzKnB+lyptyrokvd2Z
        7Rnex53HSQoyctrKYh7H0nQGaC0MXbTIVDbSF+sEjA==
X-Google-Smtp-Source: AGRyM1uaPmO1+JFXQo6wupY7ns+3WPbbWvmOzzOUNbM8vu7hRg420BV856+U4FtUIQwAYEw/LDUBD1CHl3w4Yiql7D4=
X-Received: by 2002:a05:6512:1317:b0:47f:528e:6a32 with SMTP id
 x23-20020a056512131700b0047f528e6a32mr9708569lfu.354.1655724762625; Mon, 20
 Jun 2022 04:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZm_C=o-rc4a+u_8-pFJtmL_2drwczASMRTqszamrks5Zm_OA@mail.gmail.com>
 <CAG48ez2PVMs-CeLoZtvPq2EeQqOg05mm3AuvEE_pr9Sog0O5og@mail.gmail.com> <CAMZm_CmW7pHwfEfCQfXRJPiHOjeGviQunfwxY_1ejrihKab5rA@mail.gmail.com>
In-Reply-To: <CAMZm_CmW7pHwfEfCQfXRJPiHOjeGviQunfwxY_1ejrihKab5rA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 20 Jun 2022 13:32:06 +0200
Message-ID: <CAG48ez2OcfTQ4SRbY89uHDJG6QujSfChaO4B3=zgGpj=9J8bdA@mail.gmail.com>
Subject: Re: pgprot_encrypted macro is broken
To:     Federico Di Pierro <nierro92@gmail.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 20, 2022 at 9:39 AM Federico Di Pierro <nierro92@gmail.com> wrote:
> > Why does your driver need to use that macro? pgprot_encrypted() is
> > mostly only directly used by core kernel code, not by drivers... and
> > if memory encryption is enabled, almost all memory mappings created by
> > the kernel should be marked as encrypted automatically.
>
> This is interesting; i don't really know the history behind our piece
> of code; as far as i understand,
> we have a shared ring buffer with userspace, onto which we push tracing events,
> and we must mark it as encrypted when
> the kmod runs on an AMD SME enabled kernel to allow userspace to grab sane data.
>
> This is the commit that introduced the change (if you wish to give it a look):
> https://github.com/falcosecurity/libs/commit/0333501cf429c045c61aaf5909812156f090786e
>
> Do you see any workaround not involving `pgprot_encrypted` ?

If you do have to use remap_pfn_range() to map normal kernel memory,
then you might want to use vma->vm_page_prot instead, like a few other
places in the kernel do.

(Alternatively you might want to use remap_vmalloc_range() to map
vmalloc pages into userspace, but note that that has very different
semantics - I believe that installs a normal page reference rather
than a raw PFN reference, so that would permit get_user_pages() calls
on the range.)
