Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB16EB254
	for <lists+linux-api@lfdr.de>; Fri, 21 Apr 2023 21:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjDUTio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Apr 2023 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDUTin (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Apr 2023 15:38:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB22702
        for <linux-api@vger.kernel.org>; Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a686260adcso28154145ad.0
        for <linux-api@vger.kernel.org>; Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682105921; x=1684697921;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PxXQ+D8Pkaph99A6al2RDXs7bG5gkRFhfZgwGF4wYvE=;
        b=GiMmLe1sjlCmCoc1pgVNOWYWw8FvBNlPV622rv+M0T5Tlf34uZLwu3sJYsAve8IU+i
         k8QzRcpkjwzHtVBIqqmR5egwBT+Z4DeCzoPxOX3M9mn2rsKiRbxVXV2e5jpyEWwb7E/J
         Iu6liw05mPoh1QoaPJE5E1co2ET6dCkracvIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105921; x=1684697921;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxXQ+D8Pkaph99A6al2RDXs7bG5gkRFhfZgwGF4wYvE=;
        b=MDIhh4V5i32onI4MOvNSuvwFY/6ZNv9vT7GJSH9HXAtEvXGOpWPBoY/aKqc5Wg2x7N
         T99atAiXji4FNcXIIEg8nNn7PqWlomog0vedI8E9c/dCG69kwH7O7rVqEsvZYOpyGE1h
         AndNCSZborYtXH39qz3C53PpAMwDJq863IY0qtecVx1DEabJLuqqj/uYt9EJSt88uZ8F
         RlSJRcs1a995oyPG/2feDPJdHIuQqHOIrsKjjt/FzCUVpSJB4sJVo5C33fSJ1DFrN4rI
         vj6wmaru2S2xz1NrMvxXBLC5spBp5kxxIVTHzp0aJVi2wYHPWvLh4weixIs4BotG5TPq
         +Ogg==
X-Gm-Message-State: AAQBX9dNiH3us0kSG+EnZkTeQobICkqS6rVIvmsQkYVYGCt3QtwhLepm
        Px2n12jBGfWBEDNr4LRzdEEMaQ==
X-Google-Smtp-Source: AKy350bT27YPbLT0jehhGpZQfIuRO27PeJRL1FZAIZKkOtlY3DgAtQDG+XFh640pJIVkRMqwCU7AcA==
X-Received: by 2002:a17:903:120d:b0:1a6:9289:6b with SMTP id l13-20020a170903120d00b001a69289006bmr6979869plh.30.1682105921399;
        Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709027b8d00b0019edc1b421asm3061222pll.163.2023.04.21.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:38:41 -0700 (PDT)
Message-ID: <6442e641.170a0220.1153c.6bb5@mx.google.com>
X-Google-Original-Message-ID: <202304211238.@keescook>
Date:   Fri, 21 Apr 2023 12:38:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 06/11] LSM: wireup Linux Security Module syscalls
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-7-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:54AM -0700, Casey Schaufler wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
> system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
