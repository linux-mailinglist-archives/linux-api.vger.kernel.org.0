Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC62622480E
	for <lists+linux-api@lfdr.de>; Sat, 18 Jul 2020 04:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGRChi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jul 2020 22:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGRChi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jul 2020 22:37:38 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8EC0619D2
        for <linux-api@vger.kernel.org>; Fri, 17 Jul 2020 19:37:38 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so8940897ila.3
        for <linux-api@vger.kernel.org>; Fri, 17 Jul 2020 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VxBmq9zk+mt3QchkvERG05uOiR4MmYSQ5u0UtW39ne8=;
        b=ezFN8nfqq8Prd3xOrHacmxRYHm5j62NHY76Cn4nRbKFyhPp16XVyK/9x7jK7VPAcnP
         w+YFRJmsPp0JtABpw9yfCq1IQkgigRpyo2jAhH7T8s4bhv77YPdrfUUuyi2r1+lU90Tn
         ccRnMRR7+pMh2slT54RYBk+Zh7p2pAk++3LSE/icqjRTMmADdz24c3YjONp2xMK6QuI9
         N7jcJA99s90LQKQAPdZUl+0wsk5ZcKYYWAbf31QakPPtu+5UvGoVD/VfyrvOx+EYl0kN
         zyiJqo0g2HolX7UXqFAfIGSOMu6rxtSdq0a4QLfZkI3DHvd1TYYmYSSqKQjWzn1HPHiN
         Mdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VxBmq9zk+mt3QchkvERG05uOiR4MmYSQ5u0UtW39ne8=;
        b=in16cg4zeqdqdoMBMRjO5IabNzPcdK58Szoq1BzmThi73hx/Pfp6yFbwImYKhVGwds
         UnFlgwlC17ewKQNppRCOXOG4daETM7cbMKsI1I3tJ2NzxklYsWgatL+VdXIAWxgHCe+z
         L0ekoaH+ZD9EE5fie4x0g65Wv+l4YworvAvz84vxhG7+yyKi2ZxUrYPv7KbWgzTjl15D
         /L+4FAaeFGtosiAge//CfPhylifN47flr6u+W56vsuw5pJz1V5IeXhBf94z/qwcKJSUJ
         ZIWZPR0c3v3vgvPi94VA3Ei5il1GyFRaTADWlU9ZcvXJ11QdNvV0IRpPgh/1jCa0s9CN
         3uXg==
X-Gm-Message-State: AOAM532yINqLnuN+HWtQhigpoKf4IhU4/kOEMLS7JrMu6pxce53lnATA
        +x+bSoovoCP4oIs/yjicapnhP8Ebw3ZdfJzTH+Y+D8vYsuVKTg==
X-Google-Smtp-Source: ABdhPJwvFfHsJlapTeLgdB0Qn+Cqne3AUFqEaOEI4aXACsaDmVDNGQVKTOnKOLm3MMTR+lwZ6krqIftfJ5o/AwISVQc=
X-Received: by 2002:a05:6e02:926:: with SMTP id o6mr12862413ilt.239.1595039857223;
 Fri, 17 Jul 2020 19:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200717104517.2275-1-minhquangbui99@gmail.com> <87k0z1ptbu.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0z1ptbu.fsf@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Minh_B=C3=B9i_Quang?= <minhquangbui99@gmail.com>
Date:   Sat, 18 Jul 2020 09:37:25 +0700
Message-ID: <CACtPs=FWBJb-WmKGau56euj8Mt_pAXAF5jY-DdjhTV7pa6h4jA@mail.gmail.com>
Subject: Re: [PATCH] syscall.h: fix comment
To:     Thomas Gleixner <tglx@linutronix.de>, trivial@kernel.org
Cc:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi, I actually find the file reference quite useful for me to look for
syscalls definition.

V=C3=A0o Th 7, 18 thg 7, 2020 va=CC=80o lu=CC=81c 07:20 Thomas Gleixner
<tglx@linutronix.de> =C4=91=C3=A3 vi=E1=BA=BFt:
>
> Bui Quang Minh <minhquangbui99@gmail.com> writes:
>
> > The comment shows wrong file name that contains the syscalls' definitio=
n
> >
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> >  include/linux/syscalls.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 1815065d52f3..a3d053f715e2 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -741,7 +741,7 @@ asmlinkage long sys_settimeofday(struct __kernel_ol=
d_timeval __user *tv,
> >  asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
> >  asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
> >
> > -/* kernel/timer.c */
> > +/* kernel/sys.c */
>
> How about just removing the file reference completely. It has no value
> at all.
>
> Thanks,
>
>         tglx
