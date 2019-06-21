Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD364EFF0
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUUSQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 16:18:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36909 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUUSP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 16:18:15 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so1694450iok.4
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8efNcZtDwk7IidLHvLtP2hUl2fc9Kq5GohdU6xk+B0=;
        b=Xj6Qle4/q+GM5Ky8b2Khzf+oX1HiCniPCrEDrmA+nj/WMc5akAtYIQ6OJAj94ohBnb
         aX/9RTXO5LkDnk+mBUQQ3x5MOXNAP593Aaj9qJC62m3BuAAYVd0BM7x93MxB/eZMb564
         ViDCqclpjT6u2cPNdJPmy22KXsTS0PnyoaQr4/78/7lxat7WAmkNrYzoalaarcBaxu4F
         NSSswrNR2IN5nwO5k82C1Yn/EoGPNInSbjbOYm6PbKtTaMEFc7ghnTss+GAsTc0VT3co
         iuuiNOnnE44+qY9sKAADPI3IEyStp11UrDg0PBvvcQhHnmGq9z6GO7nxez9WzxkFMPbs
         k7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8efNcZtDwk7IidLHvLtP2hUl2fc9Kq5GohdU6xk+B0=;
        b=JmFjCuIHL2Tg95mGy9aMEFxg1u5JgFVN5pbEHtZPtPMVZoZ3V5RxYww7cOENg3PaJ1
         CZMoplxcoubrgjDF8luFdqaqgmc+82RHRfyWxGb7hxLmAqYMO0VoiEeU/zabZbvZWBYx
         yYSFA4AVrnLmAfJcTFdb+gF1b8JfVwW8c4leYaaq/VuFzq3iLwheJR3K6B19stIGuUGi
         gumJOGfi0yKzLlk5YR8al8Baf2ANz8/WtkLEMmh62LC3ZkNab/TLdmpJ02buej4gdpYw
         BwJ9Y271hrD/su/oVshXmsvUdhEIbHbeqXCFQagih3iO16+fckRg36/j9prsW7VoE06v
         aP+w==
X-Gm-Message-State: APjAAAX8nUcIQMjcqwgg+PMR+izEe8yDWa8fNPT3hbvPDS+4DbXo7OlP
        pcWGoPVariKUCQmHS+QINYCAlgQyndEtFjdoUEWQFQ==
X-Google-Smtp-Source: APXvYqy23qbovsSsoFJ0RjtLQmZBZKdQgbpWtLEgyUTQHuLRdPlhf28KgpZ4L8+7/6SG64J+AK2cPMuORXLcoLNPoN4=
X-Received: by 2002:a05:6638:3d3:: with SMTP id r19mr12698566jaq.53.1561148294551;
 Fri, 21 Jun 2019 13:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com> <20190621064340.GB4528@localhost.localdomain>
In-Reply-To: <20190621064340.GB4528@localhost.localdomain>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:18:03 -0700
Message-ID: <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 11:43 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 03/26/19 at 11:27am, Matthew Garrett wrote:
> > From: Jiri Bohac <jbohac@suse.cz>
> >
> > When KEXEC_SIG is not enabled, kernel should not load images through
> > kexec_file systemcall if the kernel is locked down.
> >
> > [Modified by David Howells to fit with modifications to the previous patch
> >  and to return -EPERM if the kernel is locked down for consistency with
> >  other lockdowns. Modified by Matthew Garrett to remove the IMA
> >  integration, which will be replaced by integrating with the IMA
> >  architecture policy patches.]
> >
> > Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> > cc: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_file.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 67f3a866eabe..a1cc37c8b43b 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >               }
> >
> >               ret = 0;
> > +
> > +             if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
> > +                     ret = -EPERM;
> > +                     goto out;
> > +             }
> > +
>
> Checking here is late, it would be good to move the check to earlier
> code around below code:
>         /* We only trust the superuser with rebooting the system. */
>         if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>                 return -EPERM;

I don't think so - we want it to be possible to load images if they
have a valid signature.
