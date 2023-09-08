Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11168798A3D
	for <lists+linux-api@lfdr.de>; Fri,  8 Sep 2023 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjIHPxT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Sep 2023 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbjIHPxT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Sep 2023 11:53:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4691FC6
        for <linux-api@vger.kernel.org>; Fri,  8 Sep 2023 08:53:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c0d262933so1909666b3a.0
        for <linux-api@vger.kernel.org>; Fri, 08 Sep 2023 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694188394; x=1694793194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQx1kUp7bNPWWvaPuHSH3vkQvd7V/izVkgfg/txUUi4=;
        b=OaiTS1tICwFJF+/RY1Xzh/ZsodJq7nbzQc3QG2ZRs6RrVrmw787GmKmbgTk0kovCmq
         C+JFDlZZ6chY3NbFBm1O4WxE2BvUJjBIsW3cIsFygtEhIj2lnmjOhOED+COcxGQZCF8c
         Z73cEgCE5WJ2X29IECUXudEhShNWrmxIItQTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694188394; x=1694793194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQx1kUp7bNPWWvaPuHSH3vkQvd7V/izVkgfg/txUUi4=;
        b=Ylmj5TZ9FqQaLuCtRAOFb6aw/6y71JPgwT7wjUP0uyZBrCHbKR+Y1Dm0YwZ6lbCZq2
         DX8ae9D6s9Yaj3/Qaw2V3P+NkRr/tC511MnpUSSrUJDo5SZ6cDHwaZ1JRAtYHRZdwkH+
         yyRD0z0AWtjp680YoPiWraYEt5dxshNf+90RliS61RTT7JIMdJad2Lym1Dw7cXymAtL6
         w8LnKiQ0owlah0bFbIqujdeM2k1A/ihyjPaln+NIsfdyLEJzmtGjPkDCkBZ3/WKP2Ljm
         nBgVo/srILzAvOD1ZAD/3rPtQTishC9coMdJpWOuX4y2aGCthlalZh6d/E9ewTkrXQgG
         56hg==
X-Gm-Message-State: AOJu0Yy72D/SjcQmQIoGRLNwuq1yhvHlTHkOif0PuMY5m1VgJFfq9Cnk
        ioe9fJW1K1v/yCrxM7uI8v4UlA==
X-Google-Smtp-Source: AGHT+IEliwiiooCll85Yj0LDwX5ViN/97JOj0IWpnWCn/2/6T/sxBDfX899PjqPzJSkMTgqIvC0kJA==
X-Received: by 2002:a05:6a00:b95:b0:68a:45a1:c0e1 with SMTP id g21-20020a056a000b9500b0068a45a1c0e1mr3099625pfj.0.1694188393680;
        Fri, 08 Sep 2023 08:53:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79103000000b0064fd4a6b306sm1476224pfh.76.2023.09.08.08.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:53:13 -0700 (PDT)
Date:   Fri, 8 Sep 2023 08:53:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <202309080848.60319AF@keescook>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 08, 2023 at 06:14:38PM +0300, Alexey Dobriyan wrote:
> __DECLARE_FLEX_ARRAY(T, member) macro expands to
> 
> 	struct {
> 		struct {} __empty_member;
> 		T member[];
> 	};
> 
> which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,

Ewwww. Isn't this a bug in C++?

> changing UAPI structures layouts.
> 
> This can be fixed by expanding to
> 
> 	T member[];
> 
> Now g++ doesn't like "T member[]" either throwing errors on code like
> this:
> 
> 	struct S {
> 		union {
> 			T1 member1[];
> 			T2 member2[];
> 		};
> 	};
> 
> or
> 
> 	struct S {
> 		T member[];
> 	};
> So use
> 
> 	T member[0];
> 
> which seems to work and does the right thing wrt structure layout.

It seems sad to leave C++ broken, but I guess we have to do this.

Acked-by: Kees Cook <keescook@chromium.org>

> Fix header guard while I'm at it.

Hm, when did that get broken? Maybe that should be fixed separately?

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Probably a Fixes: tag would be nice too.

-Kees

> ---
> 
>  include/uapi/linux/stddef.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -39,6 +39,10 @@
>   * struct, it needs to be wrapped in an anonymous struct with at least 1
>   * named member, but that member can be empty.
>   */
> +#ifdef __cplusplus
> +#define __DECLARE_FLEX_ARRAY(T, member)		\
> +	T member[0]
> +#else
>  #define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
>  	struct { \
>  		struct { } __empty_ ## NAME; \
> @@ -49,3 +53,5 @@
>  #ifndef __counted_by
>  #define __counted_by(m)
>  #endif
> +
> +#endif

-- 
Kees Cook
