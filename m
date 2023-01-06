Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDBB66011A
	for <lists+linux-api@lfdr.de>; Fri,  6 Jan 2023 14:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAFNUN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Jan 2023 08:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAFNUL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Jan 2023 08:20:11 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F226755C9
        for <linux-api@vger.kernel.org>; Fri,  6 Jan 2023 05:20:11 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id i83so650045ioa.11
        for <linux-api@vger.kernel.org>; Fri, 06 Jan 2023 05:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODfjaAogRSQDrpJDcdV44wIkQB0J6eo+/VX7vu6a+RQ=;
        b=Of+LoJJZTMhlqKM6TD5QYSucSHpAUYBiRy3U98w/e0fNGihygPwthZWgaLH4oA4Wq6
         cifSKnlPGyedbK0LjPRlvJtAoYnPfCKYEbCJtyFTolECd0Ahj1tHGWZeYi1yBZ/nhJnv
         vMjfoyEnNAx3ZAaXrhoagiDWk2yUWXs+/XqQkfSlhRdt/pTGCEhx2/Q5b8XyN+mi4JzW
         iWv3EJUwkbNcgM4/1j/nrbtbinRHV4IBjlcRgGgLz57kKHjT409Gf0dw1NHK6UUXpFWE
         7r/3Zih4I1LH+Q5HIl7LLFfWyp3xtcxYBvGRldefpOPT7PvgVjaKHGmDIs5l4RmJ2Meo
         mOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODfjaAogRSQDrpJDcdV44wIkQB0J6eo+/VX7vu6a+RQ=;
        b=w+rbTdy1ufxIxa4v+h7XivwNiFm/VWMX03Hx+4CmHWId+uR2k/hKAdyP8vD795BwD/
         Tre+B2pP89oS9TuYRHasZohKIjGU3rOR8Eh4Cbs+yH1HF2ojNzrknE5PN0//QtWSj8Gu
         Ou4XFNDzCRGmV3oneuwvUe4+MwRAA0Rl3ZYFOpbWNIyT2cZtKG5cMMKH9xCsAyuofYbu
         A++LwzvZ10scOpMvnv5mTztRfI+zrDCZpKlfbZRcNt82kXKMDzPdXGptzAQuHnxOOsvI
         OEXxoXAAFGswC8+jZWjrQBbM3nUAyAhkBn7Um9ST8kB1OUiQ/xbRf7X0kdDieIFJZQUL
         h/RQ==
X-Gm-Message-State: AFqh2koj77o5dAe19PsLtmQHLGJKSpcHJ38qQJtqSyxexv5jHT+aLvN3
        pb3UWZn7akJZ8H62E11vc7qUUCvtuR6VgEzx9bDWoQ==
X-Google-Smtp-Source: AMrXdXsnXZg9dF2+tKS5u/QJJJHJkhTwEs6e8ljUhXQUpLjJQSjoB54WuvJKWMat9a70++y5/p/txVkNz8MnjHjZTj4=
X-Received: by 2002:a05:6602:184d:b0:6ed:9ed6:6bab with SMTP id
 d13-20020a056602184d00b006ed9ed66babmr3437742ioi.54.1673011210612; Fri, 06
 Jan 2023 05:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20230106042844.give.885-kees@kernel.org>
In-Reply-To: <20230106042844.give.885-kees@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 6 Jan 2023 14:19:34 +0100
Message-ID: <CAG48ez0Jg9Eeh=RWpYh=sKhzukE3Sza2RKMmNs8o0FrHU0dj9w@mail.gmail.com>
Subject: Re: [PATCH v3] ethtool: Replace 0-length array with flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jan 6, 2023 at 5:28 AM Kees Cook <keescook@chromium.org> wrote:
> Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
>
> net/ethtool/common.c: In function 'ethtool_get_max_rxnfc_channel':
> net/ethtool/common.c:558:55: warning: array subscript i is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
>   558 |                         .fs.location = info->rule_locs[i],
>       |                                        ~~~~~~~~~~~~~~~^~~
> In file included from include/linux/ethtool.h:19,
>                  from include/uapi/linux/ethtool_netlink.h:12,
>                  from include/linux/ethtool_netlink.h:6,
>                  from net/ethtool/common.c:3:
> include/uapi/linux/ethtool.h:1186:41: note: while referencing
> 'rule_locs'
>  1186 |         __u32                           rule_locs[0];
>       |                                         ^~~~~~~~~
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: kernel test robot <lkp@intel.com>
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Cc: Amit Cohen <amcohen@nvidia.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: don't use helper (vincent)
> v2: https://lore.kernel.org/lkml/20230105233420.gonna.036-kees@kernel.org
> ---
>  include/uapi/linux/ethtool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 58e587ba0450..3135fa0ba9a4 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1183,7 +1183,7 @@ struct ethtool_rxnfc {
>                 __u32                   rule_cnt;
>                 __u32                   rss_context;
>         };
> -       __u32                           rule_locs[0];
> +       __u32                           rule_locs[];

Stupid question: Is this syntax allowed in UAPI headers despite not
being part of standard C90 or C++? Are we relying on all C/C++
compilers for pre-C99 having gcc/clang extensions?
