Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D54692845
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 21:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjBJU11 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 15:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjBJU1Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 15:27:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0D3C28
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:27:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qw12so18871401ejc.2
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZamuEXhcVKZ56iZ3/bDfyhF3ja60Eault4YAmV7SNAQ=;
        b=TsQKwX+1pP22FCPs56/vCyqzRlBYKeuKP+V+HcYEmqly8S8QflkfYnflBEP5lT6H5b
         F5OqDGoPLeri/hXpHRWaa+8lQPdUE2328dZc2DlNg611cY7QRaeODNzYeLtGw62oGpye
         2d9QF4GSiwH6uplYVACzSv0yvdtDNJX7mh9+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZamuEXhcVKZ56iZ3/bDfyhF3ja60Eault4YAmV7SNAQ=;
        b=3fcqsmDXyTncC/AjZdm6miq5v41MFhUa/gZDvBXoBk/PVHXizC10U6cNf0qyhpecQe
         zjcaIbWAMMfISKO7t0mYJEKGnZenm6VWQnHAmR3g2uLAtvNZUHDfBj2WgkalL2E+/bkE
         4QTHB3FkSQeP6/hG0+kJgR1cjpFnO0XGOy7O0BIRPH+6VA3OuhA4FIHU2JVMrJsv2jXd
         jVj0jpcKh03zqcMWmZc46cQMYUiBleo/qYBvJxCsfzXmRAR3LiSjaj2BTE8wB+ECgmPi
         L+FPToBRpM2ESjaWs+z/aUk/FIFHAXksupgrrbgxuzJbGyoxFbIL7Cdc9lMyehUGK028
         gjQQ==
X-Gm-Message-State: AO0yUKWJkANPERaZlbBSiNehhlGQtg9ITDo/lsKkC72DViv0clZeaaxi
        PP0gLajck2Kzx1tnByUAeya0OfkzBbypnt3b59g=
X-Google-Smtp-Source: AK7set92FkCdW39nnmta83HQKzirHhK7BVFMx6RqsmDNUqSUPjavwEQaBv6IpxsVTaRZT/vZEZnkUA==
X-Received: by 2002:a17:907:6d29:b0:7c1:6e08:4c20 with SMTP id sa41-20020a1709076d2900b007c16e084c20mr21730379ejc.7.1676060839257;
        Fri, 10 Feb 2023 12:27:19 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id f15-20020a170906560f00b007add62dafbasm2827327ejq.157.2023.02.10.12.27.18
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:27:18 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id rp23so18800464ejb.7
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:27:18 -0800 (PST)
X-Received: by 2002:a17:906:9381:b0:878:8061:e114 with SMTP id
 l1-20020a170906938100b008788061e114mr1469478ejx.0.1676060838145; Fri, 10 Feb
 2023 12:27:18 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com> <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
In-Reply-To: <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:27:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
Message-ID: <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 10, 2023 at 11:56 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> i think this is almost exactly what Jeremy and Stefan are asking for
> re: notification when the system is done with a zero-copy send:

Yeah, right now it's all just "incremented page counts", I think.

Even the pipe code itself doesn't know about writes that have already
been done, but that are pending elsewhere.

You'd have to ask the target file descriptor itself about "how much do
you have pending" or something.

           Linus
