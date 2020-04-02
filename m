Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B613919C421
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbgDBO3Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 10:29:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44930 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbgDBO3Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 10:29:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id v134so2889364oie.11;
        Thu, 02 Apr 2020 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jygQ/diY941o6mpEEimAy4AjY3Bq2iWufaPGPW83eaU=;
        b=cOYd01hxJK0Y6e7aC0+Hkb0NPr8dT54zFU2z9gkuieOdkRYNwl0/R/YI0EQO+WP92D
         O8rSvsWs7GVsDJ8nik03mn6yZ+fNk0WJfgvH9IBCaqA2E7YRtoawxrxFmkHFpC8HPi1H
         e1BRNvTJTfk7IZMkolN6WSfWIdCbdPHYKG0a8LjYaTg8g+dHX3v5LZCP7Ebv3r0SKXep
         2zWGtPq6bDLl/UMg3WS7mO93G1OPYO7SzbSPc1AZda7kRyCfbMP2XRBBOX44YsouT/it
         qCTIDKEUoTF+LNtWJUiHVzSoO0HApzOTVJ1i+etGALkGfMdrSqJPzFj7w2KRcbN0LfT+
         MeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jygQ/diY941o6mpEEimAy4AjY3Bq2iWufaPGPW83eaU=;
        b=ttq8yX8Tsq1zu/mdABLqdZ0xLYMkmblUcNxZlwVvxJIx814uuqCX6smg/5uRbOkHbv
         +rVHhQhEgoiIFsWt752H0QyEoAJ7PbYIRBTFbyhTTV0VIU8qRNt/INdDtk0m0u1eAv/1
         fTv19Ej0sUWmsioIazHaklZhX512nif+AVCmA1hX14dO0oHP3VpCo6/GLHKw4XpniCiS
         EDjcpgUHbh9Tx6jE2qB/UlC8ZTXyV6yEEzptYfwxi37Q6xP1mR0uOxAcSr1T+nmE2ZmB
         +F9TO44T8+5sAC0htyEiYMrsMsuq8DLPcfHjKCHeviKCcuGB4JVZLIuW6oim89vwXhG+
         BYbw==
X-Gm-Message-State: AGi0PuagCMxLHmhRIIE9C36Kg77KWNRQgVbkLG6lylZImBF9j0M8380l
        N3RTNnERzo86sfHw1pN9GO89j9LOz4euosrlzIM=
X-Google-Smtp-Source: APiQypK/KK5SU5LGft8aOp7UNHf12bzZfCsR6/8x3di+hIijsZizrnNzLY71CZADU1QC3+aspILxKzz1e7B1CZ1j1WE=
X-Received: by 2002:aca:57d6:: with SMTP id l205mr2334809oib.20.1585837764854;
 Thu, 02 Apr 2020 07:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
 <a225bae5-e342-fee4-b7fa-c3093ca52fa0@gmail.com> <CAKgNAkhzOq2-H8Ka2Dx9ijrVZkaH9cNzKkAENM9hyQx9MBnAKQ@mail.gmail.com>
 <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
In-Reply-To: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Thu, 2 Apr 2020 07:29:13 -0700
Message-ID: <CA+zRj8WjV9Zw+a470X=CcoxQL1uaj92xey4CDsBsDNj5wdu8Dg@mail.gmail.com>
Subject: Re: clock_settime(2) error for non-settable clocks
To:     mtk.manpages@gmail.com
Cc:     Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michael,

I just sent a patch to the mailing list [1] capturing additional error
codes returned for dynamic POSIX clock devices.

Thanks,
Eric

1. https://marc.info/?l=linux-man&m=158583744306140&w=2

On Thu, Apr 2, 2020 at 4:48 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Eric,
>
> See also my changes in
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=96d951a401c65525bec0f973946b8dfb24afd670
>
> A textual table in that commit captures most of what I know. Still,
> some pieces that you mentioned are not covered. (patches welcome)
>
> Thanks,
>
> Michael
