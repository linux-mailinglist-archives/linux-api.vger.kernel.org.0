Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7FD4D3B80
	for <lists+linux-api@lfdr.de>; Wed,  9 Mar 2022 21:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiCIU7U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Mar 2022 15:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiCIU7U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Mar 2022 15:59:20 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD93B572
        for <linux-api@vger.kernel.org>; Wed,  9 Mar 2022 12:58:20 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 17so2870115lji.1
        for <linux-api@vger.kernel.org>; Wed, 09 Mar 2022 12:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb1xRrIzaTsXw5ggh9HnMsREf0OUT8EznCjFLR6Tke0=;
        b=XZFXja1i5rQb5XdOAmekW9zg/6hHAdnoz1qTfYcCGVqEela6f+IXzW/TDT5tOM1/lY
         mnlzGppp2H6pBA/Un3GU+l/f2ye3YXwiPbEstAnFSeyuj9kJFvMZCgVXKfit2c0fgo2B
         ZVSmJ5e2eppMQoSI6c9JeU6WDhCTVZwrMtOXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb1xRrIzaTsXw5ggh9HnMsREf0OUT8EznCjFLR6Tke0=;
        b=cODl1d64B+LzHp3yox8aVBqzEvQ+NSRWEEAsxF+20VXDoqzkkK7GfnVW/DYxZGdN8Y
         k3j4B82VnfDuQAAzRliJv1BjjAK0dnhDr6ufyzSJ/ipg7x7wAm/Oabghu9ofUse+EMwc
         2zBrsYKAVRtsBBP85pl7UTEECVzDpAfddOPHEwHdDI54QKBDxW0perS/VkQJne5sNShO
         LSUM63NWoHSBFv+fA1KbrVdY08cnYk9CwNGyXvV2ScEjANrOb43DgJBwKgZMpwjtmABd
         +EDp+TAZ5y0N73QzOPzOvvMcmVIZ/rjr9uG+uSCwKhRdH3pvQmVyE9HS0PHfIcqf+HKP
         vjLA==
X-Gm-Message-State: AOAM530AC2N05gswRHpv3tSCokmWegqYyc1wPf9Q9u/25TiS6Voprlf0
        Uj0lmj76/l3vmzdKMFS1dUgMKMdpfBnU/cj7Y8g=
X-Google-Smtp-Source: ABdhPJwIdwrzNmE/fAvldfUdrVs23D9GmQRqzNG2by0Qq4IFK9lYtwrJmBSY4NZeJ9wr0hbm0g/Q6g==
X-Received: by 2002:a05:651c:1597:b0:247:f79c:5794 with SMTP id h23-20020a05651c159700b00247f79c5794mr900287ljq.398.1646859498974;
        Wed, 09 Mar 2022 12:58:18 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p8-20020a2ea408000000b00247e5087157sm612506ljn.101.2022.03.09.12.58.17
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:58:18 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id h14so5908847lfk.11
        for <linux-api@vger.kernel.org>; Wed, 09 Mar 2022 12:58:17 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr940626lfi.52.1646859496995; Wed, 09 Mar
 2022 12:58:16 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:58:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHmg7UGPotZpvWsztW-p75yFCSNxwyAkBq1-OzuOZrMQ@mail.gmail.com>
Message-ID: <CAHk-=wjHmg7UGPotZpvWsztW-p75yFCSNxwyAkBq1-OzuOZrMQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Removing tracehook.h
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 8, 2022 at 4:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> While working on cleaning up do_exit I have been having to deal with the
> code in tracehook.h.  Unfortunately the code in tracehook.h does not
> make sense as organized. [...]

Thanks, that odd naming has tripped me up several times, this looks
like an improvement.

                  Linus
