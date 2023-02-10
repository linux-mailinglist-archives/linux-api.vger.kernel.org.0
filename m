Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5476929D6
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 23:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjBJWI5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 17:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjBJWI4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 17:08:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902966C7C3
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:08:55 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so19360495ejc.4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abSFB59ri4FOl7mUi8eUgUBhSEYjEYSp3hrpjZkmJ0U=;
        b=NcU1uFZdoJAjGPI44x/T/oJNFFkClW4PcLYk/vV5Feaov42tAJqpKYVo9/YlqDXw24
         MP1ObyJcJdHSRWORQxht+uP0G/aT/dcYZ9VhAyTSNq5BQ9jK4YMDeinqtABv+BxW+AIh
         cxBZ6zXZfc4dJfwH59qtqzuo+YrVtdjQpLas8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abSFB59ri4FOl7mUi8eUgUBhSEYjEYSp3hrpjZkmJ0U=;
        b=nnnvJGcBq634i1t+TSK6zjA/GX2REB7bzf6EDUd5HwztyeAnO6l/k3iDIhIcDE9FoL
         nJk/LOxM1SlpyA7/k2lbBlXzNVxnWWwW1NJtBjuQj2EBjHlHl3t8Qt0v+RQX5YqdK9w/
         gYMwjMDLw5O/PFiOSGxFepn9pNpPXXsBMQxms8+ZRd1EcXpjzAWMA1qVTz6U/c8GrepJ
         zPhextCdYyiaolOv/jQRxm5jtb3mYqG9RjIESaGDWVrACzbt80+lBXX6muznwFwNeVj2
         TA08FGqfL8xq2jDyQZKQsh6wNz8/PLt1PPMn9Yggwm+w0mayEqb/+BRSmbU9maCTbLLQ
         0k3w==
X-Gm-Message-State: AO0yUKWezxSQwsNixRZtGGui6mUrZuG7H0JR1Ps/OlYJUiP0kJ6mUP4t
        Hn/6HEbeUlSyfyDMtA/leQqW8LgKnpqtQsLeNAo=
X-Google-Smtp-Source: AK7set97bzo0t8+VqHchISCTKWpANgH8GgiAI8S0vctvwuUwQHtETR0cAWMjJCmKe2+1aFHUinQGkw==
X-Received: by 2002:a17:907:a608:b0:8af:4257:93f7 with SMTP id vt8-20020a170907a60800b008af425793f7mr7441379ejc.2.1676066933757;
        Fri, 10 Feb 2023 14:08:53 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709060c0200b008786619684csm2931297ejf.125.2023.02.10.14.08.52
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:08:52 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id c1so2267133edt.4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:08:52 -0800 (PST)
X-Received: by 2002:a50:c353:0:b0:4ac:b616:4ba9 with SMTP id
 q19-20020a50c353000000b004acb6164ba9mr189716edb.5.1676066932381; Fri, 10 Feb
 2023 14:08:52 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
 <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk> <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk> <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
 <7a2e5b7f-c213-09ff-ef35-d6c2967b31a7@kernel.dk> <CALCETrVx4cj7KrhaevtFN19rf=A6kauFTr7UPzQVage0MsBLrg@mail.gmail.com>
 <b44783e6-3da2-85dd-a482-5d9aeb018e9c@kernel.dk> <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
In-Reply-To: <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 14:08:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
Message-ID: <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
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

On Fri, Feb 10, 2023 at 1:51 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Speaking of splice/io_uring, Ming posted this today:
>
> https://lore.kernel.org/io-uring/20230210153212.733006-1-ming.lei@redhat.com/

Ugh. Some of that is really ugly. Both 'ignore_sig' and
'ack_page_consuming' just look wrong. Pure random special cases.

And that 'ignore_sig' is particularly ugly, since the only thing that
sets it also sets SPLICE_F_NONBLOCK.

And the *only* thing that actually then checks that field is
'splice_from_pipe_next()', where there are exactly two
signal_pending() checks that it adds to, and

 (a) the first one is to protect from endless loops

 (b) the second one is irrelevant when  SPLICE_F_NONBLOCK is set

So honestly, just NAK on that series.

I think that instead of 'ignore_sig' (which shouldn't exist), that
first 'signal_pending()' check in splice_from_pipe_next() should just
be changed into a 'fatal_signal_pending()'.

But that 'ack_page_consuming' thing looks even more disgusting, and
since I'm not sure why it even exists, I don't know what it's doing
wrong.

Let's agree not to make splice() worse, while people are talking about
how bad it already is, ok?

                Linus
