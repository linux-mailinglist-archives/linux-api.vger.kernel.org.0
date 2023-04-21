Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFA6EB236
	for <lists+linux-api@lfdr.de>; Fri, 21 Apr 2023 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDUTVR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Apr 2023 15:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjDUTVP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Apr 2023 15:21:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B91BD1
        for <linux-api@vger.kernel.org>; Fri, 21 Apr 2023 12:21:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b62d2f729so2178389b3a.1
        for <linux-api@vger.kernel.org>; Fri, 21 Apr 2023 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682104874; x=1684696874;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y34/3wROOwbQpwlKmyW2uqmf6l0AVBxPz5WfhNq4KHg=;
        b=kz2QyMieRrGA6qQv9ZTsMc6xckfIEZTcWfHc45KYmNBORLu99xvjM5iBQ/h6XsGjEF
         p98D6Dfv6FuoDyOTjwmXLoz2bA6HsiT1lzXl2fxmbsk99TnqhObjBpL+ZFGzyLYxaeXz
         iUF7WnzoPCom6vc//CAfNexxHcPcbC3jYjBEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104874; x=1684696874;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y34/3wROOwbQpwlKmyW2uqmf6l0AVBxPz5WfhNq4KHg=;
        b=PcmNqEOoyhKFFhJSZR+RU4G5R0LjwG5opAPxr1NDQ39QglSrQNtpCsbczBu5hEPAYi
         yOFVtyFFlTppIWWyiaicSvHz9nhGy0nJBUp/TWM/rH6TjVTOdULdziXKBIN0uRkTY17y
         4aVIqo60R14gj1ms9/WROIn5JtHk5xV7SIwolnQAlC3UfBfvu4Lzzg9o1BYymx+EByCV
         H0o6NZSTpt69ZhpO57oiObRRsrNNlOXfGqwMKd1irdhVcOKZX0RmgVtgmGbpZn8kG+5U
         C9+ggchg0G2+yC902NOCzvTXxc7HD8B0je7wWKXgvzb2eCc+DyRLC1Y1bbeTFQB+hVGa
         E4mw==
X-Gm-Message-State: AAQBX9cTae4w53j/CP6vl8yjBRqtrK6Ru6JVNPAUEVQcZDRMdgLSJd/x
        qx9dO8djecNQyZjctE238Vll3w==
X-Google-Smtp-Source: AKy350b5R7II59/hpeG8VozLIQvSTXVuykBo4PjPNx9fSIfN81f/BKJs12kaFvJI4ZVdawZu/9JU3g==
X-Received: by 2002:a05:6a00:2291:b0:63d:4752:4dad with SMTP id f17-20020a056a00229100b0063d47524dadmr8001311pfe.31.1682104874448;
        Fri, 21 Apr 2023 12:21:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b005941ff79428sm3428774pfh.90.2023.04.21.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:21:14 -0700 (PDT)
Message-ID: <6442e22a.620a0220.c118a.7436@mx.google.com>
X-Google-Original-Message-ID: <202304211221.@keescook>
Date:   Fri, 21 Apr 2023 12:21:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 03/11] proc: Use lsmids instead of lsm names for attrs
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-4-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-4-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:51AM -0700, Casey Schaufler wrote:
> Use the LSM ID number instead of the LSM name to identify which
> security module's attibute data should be shown in /proc/self/attr.
> The security_[gs]etprocattr() functions have been changed to expect
> the LSM ID. The change from a string comparison to an integer comparison
> in these functions will provide a minor performance improvement.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
