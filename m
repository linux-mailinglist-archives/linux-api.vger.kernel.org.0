Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB3692893
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 21:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjBJUpY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 15:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjBJUpX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 15:45:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65156FEA5
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:45:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id c26so14129727ejz.10
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ouszKA6QqICt+YxGce9SY3oz4SsHUe9oFN+JOLlH88=;
        b=BtUoz55elLFqQDfXVT2fRepfHO1VRasY7bNzTcVJa3+3O5Djx3ghbK7G70ibZuu5vN
         3dc49Cy8mFHNkJ1Vv/oF3CA3dF13tG/Y81zRPTekzdHD6j5UHk4GfmpJ70LOUcP2NqZ2
         LylcoEZit07hjr9sxmipoBqLVL7wknoCGK6LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ouszKA6QqICt+YxGce9SY3oz4SsHUe9oFN+JOLlH88=;
        b=vfAH5q2OwHExMSb9doSJkd2SY8DA+AuF3gdAxGlXhsRFghCwkk/RbXj8e+chYUYcwR
         HXIp356GMpjTYwJpDctlSC7zE40jhYXlrkIWEK2eY6sOxcejZhPifP+QkxDbZ6GbFtCC
         uHQkNyQGN5RqVtTbYH6xh9YCrvBL2mKa6q2mlHZu+yEaNaeCgUDU7UWzLxLMxODEmuq/
         DaUbbr0gel94pjXYWxTeEBill8kYeqJS1MfghWCoTHdVaRAUtSz9HO68/1IE3GEyrrIw
         gkff/yjDvWQC1OocDmTskuwPt77VqeGxXwOpPJKNhHtChy9BIOKOm6VTMUXJxvNScTJw
         nKFA==
X-Gm-Message-State: AO0yUKWQV/K1uqIk1hBsWZ5YcI69ag+CwrOQBk53HMefOYfDJIRXHKl8
        ecNqz84UASD8Q7PozCy8yA4xLe7xIK0dAJxcLlg=
X-Google-Smtp-Source: AK7set+1qBWkgMjOAzQU2ZQAm98nHDGt9zPeYxaZH1JmSFUAmeRs6XOFpUTef5KV6Mubr6hBFtiMvA==
X-Received: by 2002:a17:906:5815:b0:884:d15e:10f0 with SMTP id m21-20020a170906581500b00884d15e10f0mr15996309ejq.23.1676061915048;
        Fri, 10 Feb 2023 12:45:15 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ds11-20020a0564021ccb00b004a9b5c957bfsm2737524edb.77.2023.02.10.12.45.14
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:45:14 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id m8so5807943edd.10
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:45:14 -0800 (PST)
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr3298664edn.5.1676061913926; Fri, 10 Feb
 2023 12:45:13 -0800 (PST)
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
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
 <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk> <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk>
In-Reply-To: <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:44:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
Message-ID: <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
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

On Fri, Feb 10, 2023 at 12:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Right, I'm referencing doing zerocopy data sends with io_uring, using
> IORING_OP_SEND_ZC. This isn't from a file, it's from a memory location,
> but the important bit here is the split notifications and how you
> could wire up a OP_SENDFILE similarly to what Andy described.

Sure, I think it's much more reasonable with io_uring than with splice itself.

So I was mainly just reacting to the "strict-splice" thing where Andy
was talking about tracking the page refcounts. I don't think anything
like that can be done at a splice() level, but higher levels that
actually know about the whole IO might be able to do something like
that.

Maybe we're just talking past each other.

             Linus
