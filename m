Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61F31A77D0
	for <lists+linux-api@lfdr.de>; Tue, 14 Apr 2020 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437894AbgDNJvZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Apr 2020 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437964AbgDNJvV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Apr 2020 05:51:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D2C072EDA;
        Tue, 14 Apr 2020 02:51:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i7so16272422edq.3;
        Tue, 14 Apr 2020 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rqmlYsX6Ig4L8f/9zje28ecRn6nWF5ISzXFA0f6dr0c=;
        b=viGb6zZafzgvsPdJTt7sP+eFNtVC8uu2+ZAIqSTgeeAvLzmPWA4CODCd0ljvR5Mkyj
         0/DrJxUV+SG8Mssk8pLboXdVGKZuPVBoDFNOuM6LlPNcngb0k7P1C+W/OAA4qC1aiXjT
         W2iAGZGg9n06w5NyzaG3bAcQ6/9SwU1Npv91z70nN7ERPJC6eHX6QdBxqtZwXY54b289
         QXJHAu9vZDTJ+2OuozqeK3srjPu4TNxPC68Ztmz4yQ+A8g+XitMb+MDfSF0GozO7ogeX
         SxRZYIIAQg77rcd3OLEM2jPtO0PwI62BqlpB/ktRuEMufdDDVie1GBJ+62ahrbGK84hR
         R8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rqmlYsX6Ig4L8f/9zje28ecRn6nWF5ISzXFA0f6dr0c=;
        b=tgUZwmAbrZjCF+6mqJCXlNmfrb6PNDsDSfHVaHv9RkQU/2kbrNNShfBsMfiFEGbuNF
         ekv1AAKPrJ19BO1D0PsncyvuYZyajcV6booW1qlH9UxfeVrhAnOg/0Ad8M+45nUrpnny
         RYAPVtX5jy9i2TlyvRYlk1ZAib5dGE/H39PoZXvFeaVSRmWTFmp2ic0ZEODhBI9zZAUF
         LVSVveNLh1ZUqOa2UNWvkoqv0ZCmP2zCtqobgAxOUTt07jJyj/dG+Mr+Z/g2si9Td6YV
         nhUvXGlwkp5OzF54MK2vQkPNd5gswu/txJeuHKzvdBjTigLHgS9N3s1RWPRWAH8fF8by
         Kxtw==
X-Gm-Message-State: AGi0PubFsUtjNuEcjG3BcLsNfyCPHQ6Ooty7bp7+YsQ/049jXxL0sS7v
        gax6Ya4deHfXicmPp0Y3EOUFH0jtiBa4zXRFnCc=
X-Google-Smtp-Source: APiQypKp8eHSjjE16jhChIfVgTCOhYk4SKLhW5qt7sQqopmQ2+MHareRjtFeA98UxsEX++pwQZfXhSUDGga/1kTQGPE=
X-Received: by 2002:a17:906:add7:: with SMTP id lb23mr11378783ejb.6.1586857879752;
 Tue, 14 Apr 2020 02:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
 <20200411154031.642557-1-avagin@gmail.com> <CAKgNAki6uBHVTBdJvj7hzbho9Z94MWRV7ab8npduogQohRndBQ@mail.gmail.com>
 <20200413154746.39275d0981f69e57a7ecab3e@linux-foundation.org>
In-Reply-To: <20200413154746.39275d0981f69e57a7ecab3e@linux-foundation.org>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 14 Apr 2020 11:51:08 +0200
Message-ID: <CAKgNAkha+=3Lxq+AVsRqPNb9FxVEG4rx1wr=HfoV3RfosKi=Tw@mail.gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in /proc/pid/timens_offsets
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 14 Apr 2020 at 00:47, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 12 Apr 2020 07:51:47 +0200 "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> wrote:
>
> > Hi Andrei,
> >
> > On Sat, 11 Apr 2020 at 17:40, Andrei Vagin <avagin@gmail.com> wrote:
> > >
> > > Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> > > names.
> > >
> > > Now the content of these files looks like this:
> > > $ cat /proc/774/timens_offsets
> > > monotonic      864000         0
> > > boottime      1728000         0
> >
> > Thanks.
> >
> > Assuming no-one has objections to the patch, please do mark for stable@.
> >
>
> `grep -r timens_offsets Documentation' comes up blank.  Is
> /proc/pid/timens_offsets documented anywhere?  If not, it should be!
> And this patch should update that documentation.
>
> I assume the time namespace feature itself is documented under clone(2)?

We're good, so far. There's time_namespaces(7) [1] and documentation
of CLONE_NEWTIME in unshare(2) [2].

CLONE_NEWTIME support for clone3() is still a work in progress [3].

Thanks,

Michael

[1] http://man7.org/linux/man-pages/man7/time_namespaces.7.html
[2] http://man7.org/linux/man-pages/man2/unshare.2.html
[3] https://lore.kernel.org/lkml/20200317083043.226593-1-areber@redhat.com/


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
