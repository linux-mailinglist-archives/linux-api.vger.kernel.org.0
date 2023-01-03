Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D744065C7F0
	for <lists+linux-api@lfdr.de>; Tue,  3 Jan 2023 21:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjACUQX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Jan 2023 15:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjACUQV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Jan 2023 15:16:21 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CD2AF8
        for <linux-api@vger.kernel.org>; Tue,  3 Jan 2023 12:16:17 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id a66so32909289vsa.6
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTnuIAJdCSnqOgUCfI1VegmgFYxeW1ngR0BDNyHkGf0=;
        b=DokQ/BEIgEpL/ia17Z2x8+os3L6Iix7X3VYwgY2oWHbqXrXltMNtHkuxWFNC0TiQoL
         cBgZVKREYRgoskXuojqZ3A1XLXXW46nqyABZQqesu1jY6qAYwaNx5oLjtODVhfjUliU3
         eVndN+o81O0zIOd96+Ti2/uGI99RMfL7MdUR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTnuIAJdCSnqOgUCfI1VegmgFYxeW1ngR0BDNyHkGf0=;
        b=RVWCeA2iE+zBS+0HE74PIVcuRHkryVLenhkDqfgO4d1tAiddvAvM4go3xS4hJMQYIj
         Uoe9zN1cAP7c6saufB2vzs0volUlfDl5UvcAV539CGZqhq90uhehRH4JvemGUwlNMo62
         9NQnVbP+uOsw3L9TgB6jUQUiAgA0St+tXDSuPujSPWwL+MHKWfI1zzT83PNemg+VEnQb
         jNWPtW04IJM2rACh6i9b2Kusaua1q9fiDQ2WVUjq3moMQ0tYWclkAGaaUJKZqGcSnPM4
         mKRJ9SOyFtbzfKXM8KN0YRvskRW0ivCWz4l5FgJI36PoopvdQ5A3aO0EOYHohlpxKEzw
         hobg==
X-Gm-Message-State: AFqh2kr8gBmdjlg/MAmjMsNgKCxmBDhksmszrAPCx0k2uwtSGAkT6cMr
        JQUlrvsBv/fs/G7hjR9IjJnG0JhZB9afokj0
X-Google-Smtp-Source: AMrXdXuqQRLXKvtyhy4bK2tNprWfni3PcmOKZTceNRJKAKpEbqGpv+NYPC+bztYqswio6HZhUoidoA==
X-Received: by 2002:a67:c21d:0:b0:3ce:871e:1a2e with SMTP id i29-20020a67c21d000000b003ce871e1a2emr4763938vsj.23.1672776976018;
        Tue, 03 Jan 2023 12:16:16 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id u2-20020a37ab02000000b006fc92cf4703sm22152684qke.132.2023.01.03.12.16.13
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 12:16:13 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id p12so15358432qkm.0
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 12:16:13 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr2045085qkg.594.1672776973189; Tue, 03
 Jan 2023 12:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
In-Reply-To: <Y7SJ+/axonTK0Fir@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 12:15:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
Message-ID: <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
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

On Tue, Jan 3, 2023 at 12:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> That buffering cannot be done safely currently

.. again, this is "your semantics" (the (b) in my humbug list), not
necessarily reality for anybody else.

I'm NAK'ing making invasive changes to the VM for something this
specialized. I really believe that the people who have this issue are
*so* few and far between that they can deal with the VM forking and
reseeding issues quite well on their own.

            Linus
