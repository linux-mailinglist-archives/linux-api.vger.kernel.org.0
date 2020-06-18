Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D051FEB13
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2020 07:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFRFoT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jun 2020 01:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgFRFoT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jun 2020 01:44:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E0BC06174E
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 22:44:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so4620277ilr.4
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 22:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gH/x0oDLYUk0nS+IXCzWPiimVHHxMC4HoKo1l1rlP/E=;
        b=lGFOP9rFB22JoMWJe8TZqIkyUd208m7bqz1ZlfmrcibnxVnERGGCB4D+RCsvLy2uDV
         y1mRnQnYWA33TneZUSg2TlpuTtHLDh74+43/tJzUKsXIJO7893GMxd/7NYS5oFw/eRJp
         GG1mq4NZIaL2p83atYalP0RT9GiM/xDa6ERoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gH/x0oDLYUk0nS+IXCzWPiimVHHxMC4HoKo1l1rlP/E=;
        b=sFdRv/iR+E/gy0FMByDa0fBeJmYH7gkD5kWe7MX+HwDzuOW2mPtYM0cLbDnaLxHRgy
         9hTlsXafPKLnhJNe8eW99TtspNx9QWLujjjYUM0fpm8mz4TTITtBM54Aq6GmRtELQyWw
         YQcWYTExSWOWgKyRI1MM2y1ksf3/Ng86gjwORBsaY2YFi5Owh/UwJFF80jVgFMooixlB
         4bN7Abce1JbTtlosnBvDuVnWBT6DYbU1dOAoDOtBHrhsv1UqREzP7aTukVcQnkh3eaZ2
         LE+c5WCq+E7lQAowaoOK9DybS89wg6iEwUhcDt89WKZ7wAoO7zlY0NTNP4L2VTmwEMDq
         pCQA==
X-Gm-Message-State: AOAM533b0tfojeiApyB7SnwL3qJOBw3s7aV4563vRs1UQtyqHuenB3rx
        vAawREYZSR5Es+5dHuAiNG5nyA==
X-Google-Smtp-Source: ABdhPJzvLGYq/8bAugXUqgbGE5fQncfM/tANzVNCYghvM+N3jiC6Sq8EAStwWCbNjA8nFK/hWJiF6g==
X-Received: by 2002:a92:190:: with SMTP id 138mr2374522ilb.5.1592459056306;
        Wed, 17 Jun 2020 22:44:16 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id g15sm975468ilr.5.2020.06.17.22.44.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 22:44:15 -0700 (PDT)
Date:   Thu, 18 Jun 2020 05:44:14 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     containers@lists.linux-foundation.org, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        cyphar@cyphar.com, jannh@google.com, jeffv@google.com,
        palmer@google.com, rsesek@google.com, tycho@tycho.ws,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH v3] seccomp: Add find_notification helper
Message-ID: <20200618054413.GA18669@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200601112532.150158-1-sargun@sargun.me>
 <20200617200844.GA12976@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200617200844.GA12976@Ryzen-9-3900X.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 17, 2020 at 01:08:44PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 01, 2020 at 04:25:32AM -0700, Sargun Dhillon wrote:
> > This adds a helper which can iterate through a seccomp_filter to
> > find a notification matching an ID. It removes several replicated
> > chunks of code.
> >=20
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> > Cc: Matt Denton <mpdenton@google.com>
> > Cc: Kees Cook <keescook@google.com>,
> > Cc: Jann Horn <jannh@google.com>,
> > Cc: Robert Sesek <rsesek@google.com>,
> > Cc: Chris Palmer <palmer@google.com>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Tycho Andersen <tycho@tycho.ws>
> > ---
> >  kernel/seccomp.c | 55 ++++++++++++++++++++++++------------------------
> >  1 file changed, 28 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 55a6184f5990..cc6b47173a95 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/tracehook.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/anon_inodes.h>
> > +#include <linux/lockdep.h>
> > =20
> >  enum notify_state {
> >  	SECCOMP_NOTIFY_INIT,
> > @@ -1021,10 +1022,27 @@ static int seccomp_notify_release(struct inode =
*inode, struct file *file)
> >  	return 0;
> >  }
> > =20
> > +/* must be called with notif_lock held */
> > +static inline struct seccomp_knotif *
> > +find_notification(struct seccomp_filter *filter, u64 id)
> > +{
> > +	struct seccomp_knotif *cur;
> > +
> > +	lockdep_assert_held(&filter->notify_lock);
> > +
> > +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> > +		if (cur->id =3D=3D id)
> > +			return cur;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +
> >  static long seccomp_notify_recv(struct seccomp_filter *filter,
> >  				void __user *buf)
> >  {
> > -	struct seccomp_knotif *knotif =3D NULL, *cur;
> > +	struct seccomp_knotif *knotif, *cur;
> >  	struct seccomp_notif unotif;
> >  	ssize_t ret;
> > =20
> > @@ -1078,15 +1096,8 @@ static long seccomp_notify_recv(struct seccomp_f=
ilter *filter,
> >  		 * may have died when we released the lock, so we need to make
> >  		 * sure it's still around.
> >  		 */
> > -		knotif =3D NULL;
> >  		mutex_lock(&filter->notify_lock);
> > -		list_for_each_entry(cur, &filter->notif->notifications, list) {
> > -			if (cur->id =3D=3D unotif.id) {
> > -				knotif =3D cur;
> > -				break;
> > -			}
> > -		}
> > -
> > +		knotif =3D find_notification(filter, unotif.id);
> >  		if (knotif) {
> >  			knotif->state =3D SECCOMP_NOTIFY_INIT;
> >  			up(&filter->notif->request);
> > @@ -1101,7 +1112,7 @@ static long seccomp_notify_send(struct seccomp_fi=
lter *filter,
> >  				void __user *buf)
> >  {
> >  	struct seccomp_notif_resp resp =3D {};
> > -	struct seccomp_knotif *knotif =3D NULL, *cur;
> > +	struct seccomp_knotif *knotif;
> >  	long ret;
> > =20
> >  	if (copy_from_user(&resp, buf, sizeof(resp)))
> > @@ -1118,13 +1129,7 @@ static long seccomp_notify_send(struct seccomp_f=
ilter *filter,
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > -	list_for_each_entry(cur, &filter->notif->notifications, list) {
> > -		if (cur->id =3D=3D resp.id) {
> > -			knotif =3D cur;
> > -			break;
> > -		}
> > -	}
> > -
> > +	knotif =3D find_notification(filter, resp.id);
> >  	if (!knotif) {
> >  		ret =3D -ENOENT;
> >  		goto out;
> > @@ -1150,7 +1155,7 @@ static long seccomp_notify_send(struct seccomp_fi=
lter *filter,
> >  static long seccomp_notify_id_valid(struct seccomp_filter *filter,
> >  				    void __user *buf)
> >  {
> > -	struct seccomp_knotif *knotif =3D NULL;
>=20
> I don't know that this should have been removed, clang now warns:
>=20
> kernel/seccomp.c:1063:2: warning: variable 'knotif' is used uninitialized=
 whenever 'for' loop exits because its condition is false [-Wsometimes-unin=
itialized]
>         list_for_each_entry(cur, &filter->notif->notifications, list) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/list.h:602:7: note: expanded from macro 'list_for_each_entr=
y'
>              &pos->member !=3D (head);                                   =
 \
>              ^~~~~~~~~~~~~~~~~~~~~~
> kernel/seccomp.c:1075:7: note: uninitialized use occurs here
>         if (!knotif) {
>              ^~~~~~
> kernel/seccomp.c:1063:2: note: remove the condition if it is always true
>         list_for_each_entry(cur, &filter->notif->notifications, list) {
>         ^
> include/linux/list.h:602:7: note: expanded from macro 'list_for_each_entr=
y'
>              &pos->member !=3D (head);                                   =
 \
>              ^
> kernel/seccomp.c:1045:31: note: initialize the variable 'knotif' to silen=
ce this warning
>         struct seccomp_knotif *knotif, *cur;
>                                      ^
>                                       =3D NULL
> 1 warning generated.
>=20
I'm curious as to how you got clang to generate this warning. I'm running w=
ith clang 10, and
upon running with V=3D1, and adding -Wsometimes-uninitialized, I'm not seei=
ng this warning.
The following is the command called:
/usr/bin/clang-10 -Wp,-MD,kernel/.seccomp.o.d  -nostdinc -isystem /usr/lib/=
llvm-10/lib/clang/10.0.0/include -I./arch/x86/include -I./arch/x86/include/=
generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/gener=
ated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/li=
nux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Qunus=
ed-arguments -Wsometimes-uninitialized -Wall -Wundef -Werror=3Dstrict-proto=
types -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PI=
E -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wno-forma=
t-security -std=3Dgnu89 -no-integrated-as -Werror=3Dunknown-warning-option =
-mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mstack-ali=
gnment=3D8 -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -DCONFIG_X86_X3=
2_ABI -Wno-sign-compare -fno-asynchronous-unwind-tables -mretpoline-externa=
l-thunk -fno-delete-null-pointer-checks -Wno-address-of-packed-member -O2 -=
Wframe-larger-than=3D1024 -fstack-protector -Wno-format-invalid-specifier -=
Wno-gnu -mno-global-merge -Wno-unused-const-variable -g -pg -mfentry -DCC_U=
SING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-arra=
y-bounds -fno-strict-overflow -fno-merge-all-constants -fno-stack-check -We=
rror=3Ddate-time -Werror=3Dincompatible-pointer-types -fmacro-prefix-map=3D=
=2E/=3D -fcf-protection=3Dnone -Wno-initializer-overrides -Wno-format -Wno-=
sign-compare -Wno-format-zero-length -Wno-tautological-constant-out-of-rang=
e-compare    -DKBUILD_MODFILE=3D'"kernel/seccomp"' -DKBUILD_BASENAME=3D'"se=
ccomp"' -DKBUILD_MODNAME=3D'"seccomp"' -c -o kernel/seccomp.o kernel/seccom=
p.c


> > +	struct seccomp_knotif *knotif;
> >  	u64 id;
> >  	long ret;
> > =20
> > @@ -1161,16 +1166,12 @@ static long seccomp_notify_id_valid(struct secc=
omp_filter *filter,
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > -	ret =3D -ENOENT;
> > -	list_for_each_entry(knotif, &filter->notif->notifications, list) {
> > -		if (knotif->id =3D=3D id) {
> > -			if (knotif->state =3D=3D SECCOMP_NOTIFY_SENT)
> > -				ret =3D 0;
> > -			goto out;
> > -		}
> > -	}
> > +	knotif =3D find_notification(filter, id);
> > +	if (knotif && knotif->state =3D=3D SECCOMP_NOTIFY_SENT)
> > +		ret =3D 0;
> > +	else
> > +		ret =3D -ENOENT;
> > =20
> > -out:
> >  	mutex_unlock(&filter->notify_lock);
> >  	return ret;
> >  }
> > --=20
> > 2.25.1
> >=20
>=20
> Cheers,
> Nathan
