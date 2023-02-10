Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BC692A11
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 23:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjBJW0F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 17:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjBJW0E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 17:26:04 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B67F81E
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:26:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id be8so8041781plb.7
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676067964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXBM3BZPJurQG+9S0/yF7Jxgoc2wkik3nPAHNKQyPdo=;
        b=eY0+sbZTybV78kU4F5RyhlTTieDuYC/1pDq/vkQQMcv9vDtRqvE2g9kwEntYdcyTrt
         msUolMacnGU7DJkIhD9N6JVExK1nRR8RUYq/D9x3qQyos1xsIlXw2ehNnUeYIIz3pO4H
         jk1ieGaRePZ0sUA4pBYaOnuyegTbAIkUL3Kbdw/DxBEbBYkxa0wOVApe9XfGWMNabSIA
         82MRfujUo21oqiIUpP4w3R46gkXWqr5sG74oOfWPkhN+DvnuE3nd9uVKCL63lMgVlSOr
         GwBp3okrJ5aSeiRVLfILd4c4DQb5U4Pxf256hp5qPoLl1LATE2MC8Dcorv72kRE4ZQde
         bWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676067964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXBM3BZPJurQG+9S0/yF7Jxgoc2wkik3nPAHNKQyPdo=;
        b=yHbCMbng3ksdrDhAKQOoYQlKWHn+k9vAsbrdoldh65JoyFa6+DHzDJ+zQaSLmsugB6
         c2QOg5XA+Adn65M0m4AtSfMnV7y05s9fxG6j7NPlgCm9mVOtAJOQ9hMCgc9ajlyyQ5JX
         W2b+m4RgMz2ZUn+iMHzSBAQKAYTHyQmZT6appjn0tu7XfgqLqpvvOVnpbJY58lnwT8Q1
         n9aWlLcUwBnf1mo0nNBkAshgcoTy8gzoDhxxTw/X0AfZ7j8V4LBXHUrJY1dL8SDF8TVz
         s6wvgfp4eQjVTbpmiXN85V0XeG9EMdaWYsxhzZG1YcqUrspmt1hGJu43I4voJR50RqA6
         qhgQ==
X-Gm-Message-State: AO0yUKXue2I/219/HZ8uisUsB59XPkxEnhFb/0glQQSKWXihFcI2YBHh
        ToLKBb6I32eYAOfx6c6ruZIAeA==
X-Google-Smtp-Source: AK7set+GrkUIVowp8cBbgQHdtPTA9kJYbebkONcykH0FZvMiCq2V47NSvr+b8gJtPFWlvvKx7UygHQ==
X-Received: by 2002:a17:903:182:b0:199:1292:53cd with SMTP id z2-20020a170903018200b00199129253cdmr17899305plg.1.1676067958914;
        Fri, 10 Feb 2023 14:25:58 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jb1-20020a170903258100b001990c6c16ebsm3856968plb.37.2023.02.10.14.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:25:58 -0800 (PST)
Message-ID: <824fa356-7d6e-6733-8848-ab84d850c27a@kernel.dk>
Date:   Fri, 10 Feb 2023 15:25:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: copy on write for splice() from file to pipe?
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ming Lei <ming.lei@redhat.com>
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
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
 <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk>
 <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk>
 <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
 <7a2e5b7f-c213-09ff-ef35-d6c2967b31a7@kernel.dk>
 <CALCETrVx4cj7KrhaevtFN19rf=A6kauFTr7UPzQVage0MsBLrg@mail.gmail.com>
 <b44783e6-3da2-85dd-a482-5d9aeb018e9c@kernel.dk>
 <2bb12591-9d24-6b26-178f-05e939bf3251@kernel.dk>
 <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
 <CAHk-=wjUjtLjLbdTz=AzvGekyU1xiSL-wAAb7_j_XoT9t4o1vQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjUjtLjLbdTz=AzvGekyU1xiSL-wAAb7_j_XoT9t4o1vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/10/23 3:17?PM, Linus Torvalds wrote:
> On Fri, Feb 10, 2023 at 2:08 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>  (a) the first one is to protect from endless loops
> 
> Just to clarify: they're not "endless loops" per se, but we have
> splice sources and destinations that always succeed, like /dev/zero
> and /dev/null.
> 
> So things like "sendfile()" that are happy to just repeat until done
> do need to have some kind of signal handling even for the case when
> we're not actually waiting for data. That's what that whole
> 
>         /*
>          * Check for signal early to make process killable when there are
>          * always buffers available
>          */
> 
> this is all about. See commit c725bfce7968 ("vfs: Make sendfile(2)
> killable even better") for a less obvious example than that
> "zero->null" kind of thing.
> 
> (I actually suspect that /dev/zero no longer works as a splice source,
> since we disabled the whole "fall back to regular IO" that Christoph
> did in 36e2c7421f02 "fs: don't allow splice read/write without
> explicit ops").

Yet another one... Since it has a read_iter, should be fixable with just
adding the generic splice_read.

-- 
Jens Axboe

