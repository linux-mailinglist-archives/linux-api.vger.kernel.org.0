Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5260D1FEB3B
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2020 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgFRGEu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jun 2020 02:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgFRGEs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jun 2020 02:04:48 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78228C06174E;
        Wed, 17 Jun 2020 23:04:48 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g7so3606615oti.13;
        Wed, 17 Jun 2020 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PFBRcisrxcdT2GNCJlysWqIQRHhxPyF35WC7Sw0CFJ4=;
        b=I4ZOINg4XbtlGzruPpeQe/WtahFpxH4V8rBhuNfNLg4ImYByAgkUuh/6hW/nzFeS/g
         bqJiOR81BuYZEnW1GqB5Gsfk7nIsO4o4x7GeopHDcs6az/PbX55yYyy9lsHsk7etLMH3
         IpwFw2pyX04Hcuq5WUfsOO9eO9mDiUCYka6CnQp0plqN7sJqPAOIi/FVp23OWT8nLTYY
         9Kxxx5p7xf7PGeEtL7pKhVM8++m/p2nVTUS3XtECQU8J/Ju7y3d36XngL5vu/376QgE4
         BLXSv9dktv76xM+d0US0dPMlCXmGX/n5UY++TLW9Qodty+qkwJ1SoeFLu8ory/2rw1wq
         LtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PFBRcisrxcdT2GNCJlysWqIQRHhxPyF35WC7Sw0CFJ4=;
        b=j1Ykln55k3O709QlW5Bl2xkJIPDSRXWwVqH5cnEjCmHpwH4aTYYFqcgGRzrKobNyyQ
         TO12BZJ4A1FfkRh47cU3jifFeP5o43RMJCxMdIKdg37E1TTT0bFD+e1sJlqcsZIemBj1
         nWvdtOudyGqCVjxmmPJOOv/TDDzEraibB84+ip/PNa+dFyOPtqjH0AsfPwB3UU20fTSG
         RmKlpD/7ZopqwkwNzif4JnJm7Z0l+qOU62KqH47e4GpKfRWpS0KBsGgEcqmFK38qo1kZ
         kgYa+yWu1aFpEdOMXx4ID9qSwh5rbJh+9Jx/dMWW87C8u1z7SJgrilv8ETGvee0eOITc
         15NA==
X-Gm-Message-State: AOAM533aV6Nc6xnUznvu0qToWDismkE8ZvALabcgGtyVtphoEpbd/WvT
        ymnhiY4EP8/5yTrYVkEVrNM=
X-Google-Smtp-Source: ABdhPJyQdLghNKc2N+kWtm6ifgnu53yuZbVj2st7hdzPhwjqqiPl03QN2viAKNcayk34jWdzRbF0Uw==
X-Received: by 2002:a9d:a14:: with SMTP id 20mr2263456otg.292.1592460287636;
        Wed, 17 Jun 2020 23:04:47 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id n9sm504136oom.45.2020.06.17.23.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 23:04:46 -0700 (PDT)
Date:   Wed, 17 Jun 2020 23:04:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     containers@lists.linux-foundation.org, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        cyphar@cyphar.com, jannh@google.com, jeffv@google.com,
        palmer@google.com, rsesek@google.com, tycho@tycho.ws,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH v3] seccomp: Add find_notification helper
Message-ID: <20200618060445.GA3230200@ubuntu-n2-xlarge-x86>
References: <20200601112532.150158-1-sargun@sargun.me>
 <20200617200844.GA12976@Ryzen-9-3900X.localdomain>
 <20200618054413.GA18669@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200618054413.GA18669@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 18, 2020 at 05:44:14AM +0000, Sargun Dhillon wrote:
> On Wed, Jun 17, 2020 at 01:08:44PM -0700, Nathan Chancellor wrote:
> > On Mon, Jun 01, 2020 at 04:25:32AM -0700, Sargun Dhillon wrote:
> > > This adds a helper which can iterate through a seccomp_filter to
> > > find a notification matching an ID. It removes several replicated
> > > chunks of code.
> > >=20
> > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> > > Cc: Matt Denton <mpdenton@google.com>
> > > Cc: Kees Cook <keescook@google.com>,
> > > Cc: Jann Horn <jannh@google.com>,
> > > Cc: Robert Sesek <rsesek@google.com>,
> > > Cc: Chris Palmer <palmer@google.com>
> > > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > > Cc: Tycho Andersen <tycho@tycho.ws>
> > > ---
> > >  kernel/seccomp.c | 55 ++++++++++++++++++++++++----------------------=
--
> > >  1 file changed, 28 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index 55a6184f5990..cc6b47173a95 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -41,6 +41,7 @@
> > >  #include <linux/tracehook.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/anon_inodes.h>
> > > +#include <linux/lockdep.h>
> > > =20
> > >  enum notify_state {
> > >  	SECCOMP_NOTIFY_INIT,
> > > @@ -1021,10 +1022,27 @@ static int seccomp_notify_release(struct inod=
e *inode, struct file *file)
> > >  	return 0;
> > >  }
> > > =20
> > > +/* must be called with notif_lock held */
> > > +static inline struct seccomp_knotif *
> > > +find_notification(struct seccomp_filter *filter, u64 id)
> > > +{
> > > +	struct seccomp_knotif *cur;
> > > +
> > > +	lockdep_assert_held(&filter->notify_lock);
> > > +
> > > +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> > > +		if (cur->id =3D=3D id)
> > > +			return cur;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +
> > >  static long seccomp_notify_recv(struct seccomp_filter *filter,
> > >  				void __user *buf)
> > >  {
> > > -	struct seccomp_knotif *knotif =3D NULL, *cur;
> > > +	struct seccomp_knotif *knotif, *cur;
> > >  	struct seccomp_notif unotif;
> > >  	ssize_t ret;
> > > =20
> > > @@ -1078,15 +1096,8 @@ static long seccomp_notify_recv(struct seccomp=
_filter *filter,
> > >  		 * may have died when we released the lock, so we need to make
> > >  		 * sure it's still around.
> > >  		 */
> > > -		knotif =3D NULL;
> > >  		mutex_lock(&filter->notify_lock);
> > > -		list_for_each_entry(cur, &filter->notif->notifications, list) {
> > > -			if (cur->id =3D=3D unotif.id) {
> > > -				knotif =3D cur;
> > > -				break;
> > > -			}
> > > -		}
> > > -
> > > +		knotif =3D find_notification(filter, unotif.id);
> > >  		if (knotif) {
> > >  			knotif->state =3D SECCOMP_NOTIFY_INIT;
> > >  			up(&filter->notif->request);
> > > @@ -1101,7 +1112,7 @@ static long seccomp_notify_send(struct seccomp_=
filter *filter,
> > >  				void __user *buf)
> > >  {
> > >  	struct seccomp_notif_resp resp =3D {};
> > > -	struct seccomp_knotif *knotif =3D NULL, *cur;
> > > +	struct seccomp_knotif *knotif;
> > >  	long ret;
> > > =20
> > >  	if (copy_from_user(&resp, buf, sizeof(resp)))
> > > @@ -1118,13 +1129,7 @@ static long seccomp_notify_send(struct seccomp=
_filter *filter,
> > >  	if (ret < 0)
> > >  		return ret;
> > > =20
> > > -	list_for_each_entry(cur, &filter->notif->notifications, list) {
> > > -		if (cur->id =3D=3D resp.id) {
> > > -			knotif =3D cur;
> > > -			break;
> > > -		}
> > > -	}
> > > -
> > > +	knotif =3D find_notification(filter, resp.id);
> > >  	if (!knotif) {
> > >  		ret =3D -ENOENT;
> > >  		goto out;
> > > @@ -1150,7 +1155,7 @@ static long seccomp_notify_send(struct seccomp_=
filter *filter,
> > >  static long seccomp_notify_id_valid(struct seccomp_filter *filter,
> > >  				    void __user *buf)
> > >  {
> > > -	struct seccomp_knotif *knotif =3D NULL;
> >=20
> > I don't know that this should have been removed, clang now warns:
> >=20
> > kernel/seccomp.c:1063:2: warning: variable 'knotif' is used uninitializ=
ed whenever 'for' loop exits because its condition is false [-Wsometimes-un=
initialized]
> >         list_for_each_entry(cur, &filter->notif->notifications, list) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/list.h:602:7: note: expanded from macro 'list_for_each_en=
try'
> >              &pos->member !=3D (head);                                 =
   \
> >              ^~~~~~~~~~~~~~~~~~~~~~
> > kernel/seccomp.c:1075:7: note: uninitialized use occurs here
> >         if (!knotif) {
> >              ^~~~~~
> > kernel/seccomp.c:1063:2: note: remove the condition if it is always true
> >         list_for_each_entry(cur, &filter->notif->notifications, list) {
> >         ^
> > include/linux/list.h:602:7: note: expanded from macro 'list_for_each_en=
try'
> >              &pos->member !=3D (head);                                 =
   \
> >              ^
> > kernel/seccomp.c:1045:31: note: initialize the variable 'knotif' to sil=
ence this warning
> >         struct seccomp_knotif *knotif, *cur;
> >                                      ^
> >                                       =3D NULL
> > 1 warning generated.
> >=20
> I'm curious as to how you got clang to generate this warning. I'm running=
 with clang 10, and
> upon running with V=3D1, and adding -Wsometimes-uninitialized, I'm not se=
eing this warning.
> The following is the command called:
> /usr/bin/clang-10 -Wp,-MD,kernel/.seccomp.o.d  -nostdinc -isystem /usr/li=
b/llvm-10/lib/clang/10.0.0/include -I./arch/x86/include -I./arch/x86/includ=
e/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/gen=
erated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/=
linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Qun=
used-arguments -Wsometimes-uninitialized -Wall -Wundef -Werror=3Dstrict-pro=
totypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-=
PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wno-for=
mat-security -std=3Dgnu89 -no-integrated-as -Werror=3Dunknown-warning-optio=
n -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mstack-a=
lignment=3D8 -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -DCONFIG_X86_=
X32_ABI -Wno-sign-compare -fno-asynchronous-unwind-tables -mretpoline-exter=
nal-thunk -fno-delete-null-pointer-checks -Wno-address-of-packed-member -O2=
 -Wframe-larger-than=3D1024 -fstack-protector -Wno-format-invalid-specifier=
 -Wno-gnu -mno-global-merge -Wno-unused-const-variable -g -pg -mfentry -DCC=
_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-ar=
ray-bounds -fno-strict-overflow -fno-merge-all-constants -fno-stack-check -=
Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -fmacro-prefix-map=
=3D./=3D -fcf-protection=3Dnone -Wno-initializer-overrides -Wno-format -Wno=
-sign-compare -Wno-format-zero-length -Wno-tautological-constant-out-of-ran=
ge-compare    -DKBUILD_MODFILE=3D'"kernel/seccomp"' -DKBUILD_BASENAME=3D'"s=
eccomp"' -DKBUILD_MODNAME=3D'"seccomp"' -c -o kernel/seccomp.o kernel/secco=
mp.c

I saw it on a variety of configs but the one that is probably the
easiest to reproduce with is arm32 defconfig:

$ curl -LSs https://lore.kernel.org/lkml/20200601112532.150158-1-sargun@sar=
gun.me/raw | git am

$ make -skj"$(nproc)" ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- LLVM=3D=
1 O=3Dout/arm distclean defconfig kernel/seccomp.o

Cheers,
Nathan

> > > +	struct seccomp_knotif *knotif;
> > >  	u64 id;
> > >  	long ret;
> > > =20
> > > @@ -1161,16 +1166,12 @@ static long seccomp_notify_id_valid(struct se=
ccomp_filter *filter,
> > >  	if (ret < 0)
> > >  		return ret;
> > > =20
> > > -	ret =3D -ENOENT;
> > > -	list_for_each_entry(knotif, &filter->notif->notifications, list) {
> > > -		if (knotif->id =3D=3D id) {
> > > -			if (knotif->state =3D=3D SECCOMP_NOTIFY_SENT)
> > > -				ret =3D 0;
> > > -			goto out;
> > > -		}
> > > -	}
> > > +	knotif =3D find_notification(filter, id);
> > > +	if (knotif && knotif->state =3D=3D SECCOMP_NOTIFY_SENT)
> > > +		ret =3D 0;
> > > +	else
> > > +		ret =3D -ENOENT;
> > > =20
> > > -out:
> > >  	mutex_unlock(&filter->notify_lock);
> > >  	return ret;
> > >  }
> > > --=20
> > > 2.25.1
> > >=20
> >=20
> > Cheers,
> > Nathan
