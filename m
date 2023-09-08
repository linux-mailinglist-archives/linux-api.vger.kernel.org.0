Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDA798A7B
	for <lists+linux-api@lfdr.de>; Fri,  8 Sep 2023 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbjIHQLP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Sep 2023 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbjIHQLO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Sep 2023 12:11:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F71BF5
        for <linux-api@vger.kernel.org>; Fri,  8 Sep 2023 09:11:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68c576d35feso2096005b3a.2
        for <linux-api@vger.kernel.org>; Fri, 08 Sep 2023 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694189470; x=1694794270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5XWofP145WE08el5mK8likzGh8OJQmJSQyhLGqN5AY=;
        b=Dbk7SETP19gMkTfxq5vqgtybjsaCMa5WcAlBBq407JsTgsO1SPIp5Ffbq21uaZCX++
         c1K6A5r5xZlhA0AA00Y9qge6ZjblRnwJj3U+AHmVsJItCPYFF+lKnkl6/yxni6F5c/Mk
         r0+iW3+Rt1i6h8MlhYA/FV7atKiHfHkpPbdgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189470; x=1694794270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5XWofP145WE08el5mK8likzGh8OJQmJSQyhLGqN5AY=;
        b=C8h5+srRzCYmkIZkzISLVWocOH704OF02LlBVlQJsTvD+jeQ+g8Cvw/75BUrXG1vou
         XA/1JuByoqRTjC3skKvlcD88He2mAt0bit1VM3eVsb8onAfOBy+Q4hz6wAUX9sLv1lwv
         6i4E2aUSkmnw8hCYqswzQJfRPPnNEFaLRh+XhTeiQCM3F8b0NwRtrnUfJXyUVvQmhmdS
         aq+SFOk9ayrLH6KU68pmjH81EPf0iSRaOmC4JG15nhSCMz/V7wNzp/oL/lVWP5MoWHFc
         U82l8cTToeuUbzVeUgNLvcr+X0jT66hScqOwK9zsLMTx6Hd2X0ftHHFr///NrSim9wHC
         fQwQ==
X-Gm-Message-State: AOJu0YzQ2N7uYWgLvDW5Gevr7HzwSfmnkv4UOUv9X6tKUlwUWV2pgixI
        jpEn3Mj0ZpU83GIKh0zHidLMpw==
X-Google-Smtp-Source: AGHT+IEUvxwSx4nLanWnBC4W0VoCUil6UkDi838YCC8GDKfesIx0vo5YJCoPib+C0X/g2//i/dWCaQ==
X-Received: by 2002:a05:6a00:852:b0:68e:4303:edb8 with SMTP id q18-20020a056a00085200b0068e4303edb8mr3129470pfk.30.1694189469777;
        Fri, 08 Sep 2023 09:11:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a00138e00b0068782960099sm1148785pfg.22.2023.09.08.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:11:09 -0700 (PDT)
Date:   Fri, 8 Sep 2023 09:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <202309080910.44BB7CEF@keescook>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
 <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 08, 2023 at 07:03:17PM +0300, Alexey Dobriyan wrote:
> On Fri, Sep 08, 2023 at 08:53:12AM -0700, Kees Cook wrote:
> > On Fri, Sep 08, 2023 at 06:14:38PM +0300, Alexey Dobriyan wrote:
> > > __DECLARE_FLEX_ARRAY(T, member) macro expands to
> > > 
> > > 	struct {
> > > 		struct {} __empty_member;
> > > 		T member[];
> > > 	};
> > > 
> > > which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
> > 
> > Ewwww. Isn't this a bug in C++?
> 
> Sort of, but it can't be fixed.
> 
> > > changing UAPI structures layouts.
> > > 
> > > This can be fixed by expanding to
> > > 
> > > 	T member[];
> > > 
> > > Now g++ doesn't like "T member[]" either throwing errors on code like
> > > this:
> > > 
> > > 	struct S {
> > > 		union {
> > > 			T1 member1[];
> > > 			T2 member2[];
> > > 		};
> > > 	};
> > > 
> > > or
> > > 
> > > 	struct S {
> > > 		T member[];
> > > 	};
> > > So use
> > > 
> > > 	T member[0];
> > > 
> > > which seems to work and does the right thing wrt structure layout.
> > 
> > It seems sad to leave C++ broken, but I guess we have to do this.
> > 
> > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > > Fix header guard while I'm at it.
> > 
> > Hm, when did that get broken? Maybe that should be fixed separately?
> 
> By your last commit?

:( Oops. I'm shocked this hasn't caused bigger problems.

> 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > 
> > Probably a Fixes: tag would be nice too.
> 
> OK
> 
> Fixes: c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")
> Fixes: 3080ea5553cc ("stddef: Introduce DECLARE_FLEX_ARRAY() helper")

Okay, can you please split the patch so they can be backported
separately? Then I'll get them landed, etc.

Thanks for fixing these!

-Kees

-- 
Kees Cook
