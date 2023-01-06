Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8366089F
	for <lists+linux-api@lfdr.de>; Fri,  6 Jan 2023 22:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjAFVLJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Jan 2023 16:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAFVLH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Jan 2023 16:11:07 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF167F46D
        for <linux-api@vger.kernel.org>; Fri,  6 Jan 2023 13:11:03 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id i188so2769078vsi.8
        for <linux-api@vger.kernel.org>; Fri, 06 Jan 2023 13:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TxHKlwJQCLSbYZxgdJdZSJ5mNfa7xbEinv+9m+b8dU=;
        b=JkoJF2oW8oodyFdhhEZiE+zCQjJRSe8qbnBn4Ts4FFiwa0sekyPhwMSBKHbEAYUHQ3
         r06xF755O1aHQhg/uNyi+N/5KDBJ+uaAZmpigEg23rzOQ2HcFrMDLG9jJMUNcJHfKiAj
         dE34EO7JXggOKr+Oq4bXZx2m6WRZXthUX8U5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TxHKlwJQCLSbYZxgdJdZSJ5mNfa7xbEinv+9m+b8dU=;
        b=m6KHdqo/0o3FqIu26O7RzE2U2QeKeCpdCGfdr5RKNpD3ESFgvZuWCE3GwhAGx1nT2j
         admRgXS8Sk3YzYxAeUdxoggXkcoE0EdGRX/HxHmsT6ArwVCgz9D6uAsqmd1QJW6+1O4x
         Agbkni6z3U+ncT3mpesSBfUHzFIpQIc6TLjSTL5PfLmIjZMAa11RHcHHo1SZtOVwIYwa
         Y2xunQVjZay2VKXlww2DDFnuwXM1N1lFfVASpA/naTiTh5T+Hy9VydW/TMDcPbOcDvUR
         H3s9N+PJEsN2apPleeIR9hHuQ5dLgri0zQ7Egulz/jZrNDKkq89She+QSbzc/+BRFARq
         4+0g==
X-Gm-Message-State: AFqh2ko06sFu05ddgD+oOOy+08a5xzzDYP96oEDheeNqG8RfEJcf+3sm
        vE/OsnFEQnVZHSYU3w1htd8nLXZh8UqMOQCd
X-Google-Smtp-Source: AMrXdXvLf8oAubY3WtrlPHpQYDdL9DD+RP6f3pt3LuytvUiS1qAqlR1BrGM5IAIgPyTjjMkI9UJCAA==
X-Received: by 2002:a67:edd4:0:b0:3b5:3eaa:bb0c with SMTP id e20-20020a67edd4000000b003b53eaabb0cmr24053131vsp.0.1673039462675;
        Fri, 06 Jan 2023 13:11:02 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006ce76811a07sm1120129qkp.75.2023.01.06.13.11.01
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 13:11:01 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id pe2so1351117qkn.1
        for <linux-api@vger.kernel.org>; Fri, 06 Jan 2023 13:11:01 -0800 (PST)
X-Received: by 2002:a05:620a:4720:b0:6ff:cbda:a128 with SMTP id
 bs32-20020a05620a472000b006ffcbdaa128mr2770302qkb.697.1673039460720; Fri, 06
 Jan 2023 13:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-3-Jason@zx2c4.com> <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com> <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com> <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com> <f36f19ee-5bff-4cd0-b9a9-0fe987cf6d38@app.fastmail.com>
In-Reply-To: <f36f19ee-5bff-4cd0-b9a9-0fe987cf6d38@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 13:10:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLWcKq2AdrTmTOxJKn6w4oEpEGdipWAah5Xad5-Yii6Q@mail.gmail.com>
Message-ID: <CAHk-=wgLWcKq2AdrTmTOxJKn6w4oEpEGdipWAah5Xad5-Yii6Q@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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

On Fri, Jan 6, 2023 at 12:54 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> I'm going to suggest a very very different approach: fix secret
> storage in memory for real. That is, don't lock "super secret
> sensitive stuff" into memory, and don't wipe it either. *Encrypt* it.

I don't think you're wrong, but people will complain about key
management, and worry about that part instead.

Honestly, this is what SGX and CPU enclaves is _supposed_ to all do
for you, but then nobody uses it for various reasons.

               Linus
