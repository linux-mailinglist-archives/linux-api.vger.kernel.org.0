Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4FB52BDCB
	for <lists+linux-api@lfdr.de>; Wed, 18 May 2022 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiEROcI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 May 2022 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiEROcH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 May 2022 10:32:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ED13C34F
        for <linux-api@vger.kernel.org>; Wed, 18 May 2022 07:32:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so3972089lfg.7
        for <linux-api@vger.kernel.org>; Wed, 18 May 2022 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/o8jxVzJHrKnQPYDyUAFY3NEjQoX1p3FxNxyj6gs2jo=;
        b=bXqsD/5OKiD06afoIxdd1RhVMAV2zjqVL4xb7Xr54EBlsylyb9Wkk1QlqHJEdwHgRE
         9rwcacTUnE/upPhQpvGq9LsbYdhP1B9Bg72S/dRXj8nEpgd7l0ZM+ujjwQxRRGnkFcGD
         mNXhIoVNgPnHoTQr7WuMD+i4pUl5aQ0jSHN0u7D3UsVKfBPHYVPkjTTa3oY7IHad2pHE
         Gx6+UTsexYvbkSkzn/wNS9wqQlDv3pNBNfgBiyADqiu3vrBwdAqtfCsPDdb8omg337qz
         gNQesHwQLsKQ06lU3wT9xijpTl3I4rwKTbq2eOFC0euMekwhzEfSDPYlk0zGcWLSBpvD
         KEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/o8jxVzJHrKnQPYDyUAFY3NEjQoX1p3FxNxyj6gs2jo=;
        b=vvrtD+24+PPCduHYTzW8dKYh+rXE+zzlKVJ8wBmN7ah4McpjXkJraWA2Wv988Lu4I3
         c0RVbTGasmGDqgmYdwY/9fJ38gVCfzPaGXMZ/dgqemmkg9XNImtK1F7MlLE2Dsc2xllv
         S1Kr8R6CexLidXunKcJWKtxodR2aumrO+l4x1fpNShwbXmQW7Qj1bqLZbZr6LTMIpS/P
         F1OXMHp3HUSc+u+Zem/r6niMFtbAN7pLOdlpSbV212KIDIcaqmkzarnTznpcbJmoMlI4
         CGOW/IQFBEa+7snrDr0OXdekiWkqbwsvEKrdq476f88JeNoEF/Hf3boA+w1um4gFwy+d
         +gxw==
X-Gm-Message-State: AOAM530nnroI5yDKM3XO5zgXSj8YgIhJxr+ff3p8kJKw35F585UEIOH6
        LwpR9LluS3iUzFXlhuwtJlg5bowYVUt2CU3Lw2wiiQ==
X-Google-Smtp-Source: ABdhPJwvHhNIm1ioaXivr1UG6rcLmkD8H6VcQUQxqzau9d3Y7/VhluB9oHhC+sEH5vKG0dLaXf6ExZQK4mJaVcn1YIw=
X-Received: by 2002:a05:6512:260d:b0:445:c06e:8242 with SMTP id
 bt13-20020a056512260d00b00445c06e8242mr19938085lfb.157.1652884322270; Wed, 18
 May 2022 07:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 18 May 2022 16:31:26 +0200
Message-ID: <CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, May 17, 2022 at 11:27 AM <cgel.zte@gmail.com> wrote:
> For now, if we want to use KSM to merge pages of some apps, we have to
> explicitly call madvise() in application code, which means installed
> apps on OS needs to be uninstall and source code needs to be modified.
> It is very inconvenient because sometimes users or app developers are not
> willing to modify their app source codes for any reasons.

As a sidenote: If you're going to enable KSM on your devices, I hope
you're aware that KSM significantly reduces security -
when cloud providers were using KSM, there were a bunch of papers that
abused it for attacks. In particular, KSM inherently creates
significant information leaks, because an attacker can determine
whether a memory page with specific content exists in other apps
through timing side channels. In the worst case, this could lead to an
attacker being able to steal things like authentication tokens out of
other apps.

If you see significant memory savings from enabling KSM, it might be a
good idea to look into where exactly those savings are coming from,
and look into whether there is a better way to reduce memory
utilization that doesn't rely on comparing entire pages against each
other.

See https://arxiv.org/pdf/2111.08553.pdf for a recent research paper
that shows that memory deduplication can even make it possible to
remotely (!) leak memory contents out of a machine, over the internet.

(On top of that, KSM can also make it easier to pull off Rowhammer
attacks in some contexts -
see https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_paper_razavi.pdf
.)
