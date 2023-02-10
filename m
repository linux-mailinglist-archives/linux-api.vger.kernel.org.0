Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2A6929EF
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjBJWSS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 17:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjBJWSR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 17:18:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B8F2BF17
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:18:16 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r3so6021086edq.13
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+TOeH19iOq0vdQyV1Prof3NpM6QGVmHTyGEbxYTvX8=;
        b=TFoinpe3pITLVHtLti947pihmGAzoNViv44DXoHnGTTszOCmnwyESdP0lt/lbOrP7t
         8YDtBz+IGoaYOl0Ob5HxjVWGYnebyxpw932EfN70qrgWIPO+7+T6hBCeJjUjrPieoXRM
         laPRsn73b5fpWuslCZ6zcJBfNorWMVHntxmcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+TOeH19iOq0vdQyV1Prof3NpM6QGVmHTyGEbxYTvX8=;
        b=KR66e6SOsSNPV6zOI5HyisnoDniIgGtP+WaEujT+3kQ8EM5UrEHvEa/Ql8zopZHICx
         o545+Bn1nt4huUl20/xPGg0UCBksFa3ZU1qJ0uAihFh1mBWtBa0QEU04bKK6spx+aCDF
         TH9PFmVRqYt5j5jxtm4YO6WrPrHRxDQ+E9Z7tUvmK1zWwfTJ0zZuUfuj96do0i0KDy11
         zpYc/UVnuEhsA7qV3MbxNRdwJiIrKOjPAKxnJmVXkjPwefD0Dy7nRc4HsKIo1XTD7TrR
         0lbofE3RBrGgQ1Y4ffhtonrlstss76y3FV1ZqyLbm9KqG1R1WnKtFi7YpU4HCY0FGthT
         rQuA==
X-Gm-Message-State: AO0yUKXebAwpIC+YBHtqPjb1JMbPJ0YIsU0qJiy+o0Vc/wAIYHjS44ia
        qmTHsSo+zu3+jB9C/LC8mFHJ2qqYtiTJ3af6P/Y=
X-Google-Smtp-Source: AK7set9eGBdQ5gNxp3jo4p1gaAJv5Ex4vWVt2TP9aMQDig/hHmb0T0xnai/9r40TjZGzQCbY6LL0gQ==
X-Received: by 2002:a50:998c:0:b0:4a2:4675:2162 with SMTP id m12-20020a50998c000000b004a246752162mr13151843edb.3.1676067494394;
        Fri, 10 Feb 2023 14:18:14 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id z96-20020a509e69000000b004acb6d659eesm50301ede.52.2023.02.10.14.18.12
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:18:12 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id l12so6155122edb.0
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 14:18:12 -0800 (PST)
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr3399923edn.5.1676067492117; Fri, 10 Feb
 2023 14:18:12 -0800 (PST)
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
 <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjzqrD5wrfeaU390bXEEBY2JF-oKmFN4fREzgyXsbQRTQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 14:17:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUjtLjLbdTz=AzvGekyU1xiSL-wAAb7_j_XoT9t4o1vQ@mail.gmail.com>
Message-ID: <CAHk-=wjUjtLjLbdTz=AzvGekyU1xiSL-wAAb7_j_XoT9t4o1vQ@mail.gmail.com>
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

On Fri, Feb 10, 2023 at 2:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (a) the first one is to protect from endless loops

Just to clarify: they're not "endless loops" per se, but we have
splice sources and destinations that always succeed, like /dev/zero
and /dev/null.

So things like "sendfile()" that are happy to just repeat until done
do need to have some kind of signal handling even for the case when
we're not actually waiting for data. That's what that whole

        /*
         * Check for signal early to make process killable when there are
         * always buffers available
         */

this is all about. See commit c725bfce7968 ("vfs: Make sendfile(2)
killable even better") for a less obvious example than that
"zero->null" kind of thing.

(I actually suspect that /dev/zero no longer works as a splice source,
since we disabled the whole "fall back to regular IO" that Christoph
did in 36e2c7421f02 "fs: don't allow splice read/write without
explicit ops").

            Linus
