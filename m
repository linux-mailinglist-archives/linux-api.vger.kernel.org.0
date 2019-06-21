Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32F4F040
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFUVEV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 17:04:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46465 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFUVEV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 17:04:21 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so897542iol.13
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Fh/tHiLfHzglDRmRK4MeWaH9B+D3D43UNRCXEIZlio=;
        b=JQWyLEVmQVEgB6eNmuJNoqU10ZpR9B1hs/VTTtZMK1atm2V9pgcLici+O3eq8GoZ20
         PAwvAc7mTXhsw8s6ULWRqa1ygdEyl4fl4BZxysRViMT+5gnFJGU4xYVKNZy8Q9lWrYfQ
         +9Qno0D/zVZhrHTMhFEASp79IJzkBm+AjX1taO54zAkqcnJEkUO1OL21fDu/3pmLjRc8
         CgO/JOKOHH1ocaoPktWOY4ccOBky8fxp+OqkF0pJSfnAf5v6aC6nSJdcLIZRuCu1m9jY
         J574JWeZIuizTc+yJhlGXZeTOajB38zjhNjna9YhsaqAc+ox0ywjtwHq0Wq1jv8LWMGz
         rtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Fh/tHiLfHzglDRmRK4MeWaH9B+D3D43UNRCXEIZlio=;
        b=ckJ/Z2gBPPcFFmK85k3qh9C6EUPoG8C+a10CmWifrwH1Fgg8lEyetUPOqgphhAjRhH
         EqYxA4LzTe9QZUIw/kf5AI1a+6eSsh/+i2VM664N8zcvaWZtkCqfT2wvH08y4S55VTrn
         aB186ZCTci5r9v2dJ0/09vOjMvQVG9hG3XHUSJ/L5aaYp2Jq/1ePlo9Y5hWI8m1bLSmE
         P7mty7Jh40YriijrjPVwV1Xea6tzYF+vkyalfnWlRwimO1yVnxOUwqRJXBvm+I25h+TJ
         kUHB9hrFHQps7QNceyVwh6Kw1t2ZGjcwWvO9QSLADoUnzkDPaAxHptBBz2Smb4rYngok
         4itQ==
X-Gm-Message-State: APjAAAXIn88BavtUuafWD8Lis3gl34RAeY8WLHurMdJVA1/DiIihYUad
        fk41lWUQLgM3Bx4i8zuflmWNhS+016mTbckfyjk2kA==
X-Google-Smtp-Source: APXvYqyxdCHKg+jO9Z3sbuqDNxn5VjTHJLVEcF2t+ZhmVfXWXM8SChGt9mnaivlj0TOlGOadCqPgUHEkI13I8bpCo80=
X-Received: by 2002:a02:ab99:: with SMTP id t25mr8680797jan.113.1561151059759;
 Fri, 21 Jun 2019 14:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-4-matthewgarrett@google.com> <201906202028.5AB58C3@keescook>
 <CACdnJut_C_h2JjryDxEm9U_rpSJFkVyxq3iCW9=AhwcdVig=9g@mail.gmail.com>
In-Reply-To: <CACdnJut_C_h2JjryDxEm9U_rpSJFkVyxq3iCW9=AhwcdVig=9g@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 14:04:08 -0700
Message-ID: <CACdnJutWhpgKeWWBv8AkTxBxoVempiuVRJzk7mrUF6LMmnwp4Q@mail.gmail.com>
Subject: Re: [PATCH V33 03/30] security: Add a static lockdown policy LSM
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 12:37 PM Matthew Garrett <mjg59@google.com> wrote:
> I'll check, I'm bad at finding these new fangled things.

Ah, I see - there's sysfs_match_string(), but that doesn't really work
for this case because we'd still need to do another set of checks to
see whether the level we get is in lockdown_levels, not just
lockdown_reasons.
