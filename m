Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00E692731
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 20:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjBJToi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjBJTo3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 14:44:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC87FECB
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 11:43:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so18627898ejc.4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 11:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9CpPKhHlK6PYZiwLCiEmRPX8TBc/0iQPNE26DOAPaH4=;
        b=aw1tmSCpW4mrJ0HszXDtD2cnLdLxJ09VvDp1V4n4rwC3p58zOAeSYvxH2jj3QSpNy8
         2a4GdLLV2E8+oEAhmJxMznwsQHOJctaP53SlKnfXJWHizcsvh8Au5uZTbPBm5C9TOFPn
         jenxevnrE4SLkXby1HJd4Nz5Y5U7YZhrBi6dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CpPKhHlK6PYZiwLCiEmRPX8TBc/0iQPNE26DOAPaH4=;
        b=rDqCsuGnaJ7joSZf6rwZt8AYUq3vB/ROBJvsqWNVFw/M1qT8PzMU2m2AkuGtF5dsfN
         xAcQhWGk8lzPyYS2KcDND2sijISHSbHhaxD80dCbDfIgCmS4VsHD57PUfhYoQH1JNV9F
         /4q+aAHGEKTSbBTcef+PngJkdRjRRC9Gkiky/WqN6UDpJaDkEzZ5Y0wAP7Ve+Tq9AnAR
         8wrkJemGyxXYyBq9xZgK5DEaLfJFTcYWCEm/1IFkx0r4Et1tzYEFOiLMaE9yxOEgxwhZ
         kVz4ygbt44XrHUDhV+MsjKNXb8wzH1vZmiWFoQWcOUei2J6a3jqid1i3MhfMSZzzBVzP
         Ybag==
X-Gm-Message-State: AO0yUKXwFsuk+Gw22NgkH0Q7R9zOAraq/gAz1i+UR/8Ui+8+J5bbmqj/
        rnHUQKGF3cEAK8fRGo/FQB2VpEcf/NsGgJAuBzs=
X-Google-Smtp-Source: AK7set+QMknl4eJQRCTfTZZXfpopOQR/C+hJcE9w13ughEMQT2CtIbG4oHJB8QJxBy4iOGuoOusuBw==
X-Received: by 2002:a17:906:46d3:b0:88d:ba89:183f with SMTP id k19-20020a17090646d300b0088dba89183fmr10456696ejs.16.1676058155840;
        Fri, 10 Feb 2023 11:42:35 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b0084c6ec69a9dsm2764026ejb.124.2023.02.10.11.42.34
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:42:34 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id q19so5677710edd.2
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 11:42:34 -0800 (PST)
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr3218470edn.5.1676058153910; Fri, 10 Feb
 2023 11:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com> <Y+aat8sggTtgff+A@jeremy-acer>
In-Reply-To: <Y+aat8sggTtgff+A@jeremy-acer>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 11:42:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgztjawo+nPjnJJdOe8rHcTYznD6u34TBzdstuTjpotbg@mail.gmail.com>
Message-ID: <CAHk-=wgztjawo+nPjnJJdOe8rHcTYznD6u34TBzdstuTjpotbg@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jeremy Allison <jra@samba.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Samba Technical <samba-technical@lists.samba.org>,
        io-uring <io-uring@vger.kernel.org>
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

On Fri, Feb 10, 2023 at 11:27 AM Jeremy Allison <jra@samba.org> wrote:
>
> 1). Client opens file with a lease. Hurrah, we think we can use splice() !
> 2). Client writes into file.
> 3). Client calls SMB_FLUSH to ensure data is on disk.
> 4). Client reads the data just wrtten to ensure it's good.
> 5). Client overwrites the previously written data.
>
> Now when client issues (4), the read request, if we
> zero-copy using splice() - I don't think theres a way
> we get notified when the data has finally left the
> system and the mapped splice memory in the buffer cache
> is safe to overwrite by the write (5).

Well, but we know that either:

 (a) the client has already gotten the read reply, and does the write
afterwards. So (4) has already not just left the network stack, but
actually made it all the way to the client.

OR

 (b) (4) and (5) clearly aren't ordered on the client side (ie your
"client" is not one single thread, and did an independent read and
overlapping write), and the client can't rely on one happening before
the other _anyway_.

So if it's (b), then you might as well do the write first, because
there's simply no ordering between the two.  If you have a concurrent
read and a concurrent write to the same file, the read result is going
to be random anyway.

(And yes, you can find POSIX language specifies that writes are atomic
"all or nothing" operations, but Linux has actually never done that,
and it's literally a nonsensical requirement and not actually true in
any system: try doing a single gigabyte "write()" system call, and at
a minimum you'll see the file size grow when doing "stat()" calls in
another window. So it's purely "POSIX says that, but it bears no
relationship to the truth")

Or am I missing something?

            Linus
