Return-Path: <linux-api+bounces-90-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D87F136C
	for <lists+linux-api@lfdr.de>; Mon, 20 Nov 2023 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7A0281FDF
	for <lists+linux-api@lfdr.de>; Mon, 20 Nov 2023 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1DDF4B;
	Mon, 20 Nov 2023 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JWwD37VO"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5A106
	for <linux-api@vger.kernel.org>; Mon, 20 Nov 2023 04:35:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso593608266b.1
        for <linux-api@vger.kernel.org>; Mon, 20 Nov 2023 04:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1700483699; x=1701088499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+BmHsiwR1uZOEjTWIK+7weK8XNEcJUbOScgakRPO9Y=;
        b=JWwD37VOPbdiIC/FpTxEkl0I5ZtrjR4N/ZBApXdexjXcNcgLfYK7QpI5zJ2AFu+3T4
         buJu9uq+2cStvh6Ld5D+U6Eh2/7d6nc5CzqSQvFIM9HUT0KWztBiyo5MUMTtFBowGwAA
         b4d8FezM7XI2fu6YfbIstt4tMR3Jeqsy3ixLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483699; x=1701088499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+BmHsiwR1uZOEjTWIK+7weK8XNEcJUbOScgakRPO9Y=;
        b=oFIJRuc1+F+qn2DMt06aJsOOwvfdPap+YwZrVp9XtE00r58m3ahq8DXi6paTB+GLCy
         tzX/NCaDdEY65E6R9HIh8u4gzrqw2tYIXzBv4BcglUkrba4T3yaIz4kSqTnn//bXHHkd
         WjYqzUvoFbU4m4/Yuy7IMnc5nyANwuUqm7K5mC7aISCcGHGc8Jbl8Kv9pXyMrqFQFkhC
         iY2faUuGbzEtc99asXWFQK04TZe1Ikb1inV0PhNTt+sm/H2XiMoa53xu/4xleLR6WYxy
         wN90SaVpCRv3cRWx1GhyvhOycMn3Epze4HA1JkeRDDu/xxfI5MzQveUtnNdy7Duig63A
         0KIA==
X-Gm-Message-State: AOJu0YxjgGBgiJq+gqrIreCyab32DUJH66cSvRn+7+w3J1t9fGpNte0v
	GWY+mawvz+fxKl4LWZffNt1vEQ==
X-Google-Smtp-Source: AGHT+IE8Z7xxN5kKC2evQWh5vGdJ3CAgi8zjsYjb6nLc9dNw8CJBJtiJN8x8tM5UXgBknGgJ/cU3Wg==
X-Received: by 2002:a17:906:20d4:b0:9be:466c:1824 with SMTP id c20-20020a17090620d400b009be466c1824mr4254446ejc.11.1700483698747;
        Mon, 20 Nov 2023 04:34:58 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-181-165.pool.digikabel.hu. [91.82.181.165])
        by smtp.gmail.com with ESMTPSA id gw3-20020a170906f14300b009a1c05bd672sm3807331ejb.127.2023.11.20.04.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:34:58 -0800 (PST)
Date: Mon, 20 Nov 2023 13:34:56 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Message-ID: <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
 <878r6soc13.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r6soc13.fsf@oldenburg.str.redhat.com>

On Mon, Nov 20, 2023 at 01:16:24PM +0100, Florian Weimer wrote:
> Is the ID something specific to the VFS layer itself, or does it come
> from file systems?

It comes from the VFS.


> POSIX has a seekdir/telldir interface like that, I don't think file
> system authors like it.  Some have added dedicated data structures for
> it to implement somewhat predictable behavior in the face of concurrent
> directory modification.  Would this interface suffer from similar
> issues?

The same issue was solved for /proc/$$/mountinfo using cursors.

This patchset removes the need for cursors, since the new unique mount ID can be
used to locate the current position without having to worry about deleted and
added mounts.

OTOH I agree that seekdir/telldir are horrible and it's probably best to at
least hide the seekability behind a stateful API:

	struct lm *lm = listmount_open(mnt_id, flags)
	do {
		num = listmount(lm, buf, bufsize);
		for (i = 0; i < num; i++) {
			/* process buf[i] */
		}
	} while (num > 0);
	listmount_close(lm);

Whether doing that in libc or in the kernel is debatable.  I don't think the
kernel API needs to be stateful, but it may allow more flexibility in the
future.  I don't know.

Thanks,
Miklos

