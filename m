Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27306928B9
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjBJUvo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 15:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjBJUvn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 15:51:43 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158297F812
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:51:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so18984551ejc.4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Azvxdn84xto/x8V66pxCf76GAuLOkrFIRsWg8lS4s=;
        b=CExvujm0mDZb5b8Q0YyIk4qMEt2KO+XrVyPAus7CXHhyvaiDKton8DMFVNJsqauRlU
         nI1nneBrMPjQD5z0K9+CdqJYNcj8cP+aS9E0t7rQMDVkDPH9lCTi56TrRMFd1OP/EM6c
         8oYMudVstq0I+TSzaRmEBx/yV05z10/f7jbHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2Azvxdn84xto/x8V66pxCf76GAuLOkrFIRsWg8lS4s=;
        b=pXsEeplI3Tvhl2qi+9dPU5eKgVIr+bhc7zGSu4ccRU5GUM2lyTYXtIiK0IZ64aNmpp
         Ay0cIKplfrr5VdD9UNEKoWap2XqSZgvNBXHvW8AkQZzEmMf8Cm11J1QS5vE13jQfeT8n
         7bweKgIHiTQhsKXG9icyxPO3xb4eW9Gs4W9hYr5JYdjPT+EAKNWTMZ23M7zjDQ0UWXZE
         O3zpjYRZ9eMoRNnzUarNchDISLG1FRkt/EeC6APqqIE69nZMbOnodZq4M6fkuPG5cIur
         D48Ee2JZwhuz0y5q6k094JoPdOMkgCNy6lv/PLUguCELZVJAV8ipZGHTvnY8oMy28zY2
         DfnA==
X-Gm-Message-State: AO0yUKWMVZB8miEqhlke0k0U5sKWqUTqRvNVxE8TztztaNLX/5AhIcMM
        WzKDOzU2WYkLgnte/pXLGBqqegdWqfHPo2ASfFo=
X-Google-Smtp-Source: AK7set+QXiVF9/U7zGsW68n3o9pAIkauUZXfINtRxdsbzeQkEFcCeYdTXlqZUgsWfCbUMQ7cgHh8Dw==
X-Received: by 2002:a17:906:7c91:b0:88c:b4c5:4006 with SMTP id w17-20020a1709067c9100b0088cb4c54006mr20965500ejo.45.1676062299062;
        Fri, 10 Feb 2023 12:51:39 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b0088f8ae18b6bsm2835130ejc.189.2023.02.10.12.51.38
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:51:38 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hx15so18897552ejc.11
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 12:51:38 -0800 (PST)
X-Received: by 2002:a17:906:d217:b0:877:747e:f076 with SMTP id
 w23-20020a170906d21700b00877747ef076mr1548367ejz.0.1676062298057; Fri, 10 Feb
 2023 12:51:38 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <f6c6d42e-337a-bbab-0d36-cfcc915d26c6@samba.org> <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
 <CAHk-=whprvcY=KRh15uqtmVqR2rL-H1yN6RaswHiWPsGHDqsSQ@mail.gmail.com> <6858a9bd-a8aa-3eaa-979d-83e1743ce85e@samba.org>
In-Reply-To: <6858a9bd-a8aa-3eaa-979d-83e1743ce85e@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:51:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=JeuB3aDX4yej=9SE-J6RR9LG28eRVfntkoQCPpHNpw@mail.gmail.com>
Message-ID: <CAHk-=wi=JeuB3aDX4yej=9SE-J6RR9LG28eRVfntkoQCPpHNpw@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        Samba Technical <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>, linux-crypto@vger.kernel.org
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

On Fri, Feb 10, 2023 at 12:45 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> I guess it would be easy to pass a flag (maybe SPLICE_F_FORCE_COPY)
> down to generic_file_splice_read() and let it create dedicated pages
> and use memcpy() from the page cache to the dedicated pages.

I really think you'd be much better off passing it off to the
*destination*, not the source.

The destination knows whether it needs to copy or not, and in the case
of at least networking, already has the copy option.

The destination might also already know whether it can use the data
synchronously, so that there isn't even any issue with "data may
change later".

In contrast, the source has no clue. It just knows "I'm a page cache
page". It would have to always copy.

               Linus
