Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63B71D6868
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEQOXT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgEQOXT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 10:23:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231CAC05BD09
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 07:23:19 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id n11so7316362ilj.4
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IbfxFWmNaCFRv5atb1UVjA4fbxw7MwwdE/4yErlVGmg=;
        b=je7fiBAlwjWMz5XOH6obv3seJ6Qc1ORc7AEna2ImpH6OqXUkGAqyKq8GUs3CsuYYXr
         KBg3CyPJpe6HvQWguYHHAHk3/VzpYEP37fKaUZ+OPo+z+V0R1gnnDq+Qtm0wMZidVsUJ
         X6WmzqTtBUq/oACqtHkCZbzRTaWsAR5uk7O9GZs7I2Nx31icT8zZtQWaxsfBYRGf2E4P
         PS+NgNCQgJB1iOzfXIbUoxtvRgWpM3ETaj18lriLt9WSB99bRQALzUT/8+De019DOL4e
         HRv2Sr+VqUp1VJq8OBs4hx2xEK79lLiabdfmgJfUofXyrOj0Dkr6RdB6S/aTVecXYRyQ
         Q7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IbfxFWmNaCFRv5atb1UVjA4fbxw7MwwdE/4yErlVGmg=;
        b=mL8IARg9PFYKT1c0OWemBjnjFuT9r58Ay8WXaNVIoi6IdSVvh1qT5w2JIVYAihR3ik
         +VQC/xQFnJipVvWs0T3j4S0+cY752aUMqIp6Mu8mp7I4S2vFZNSq6Ob+oE3lWL2jSmGh
         eFuVFu7QttWRaFm0VZNUFjvi/X1e+tu5uKMadUbllJDlTF2/3AAvhnd/PdpEEO51HJGT
         Clb0wFZJ/JBRud4cgb1khrzQ7QYMcnWmcRRXETbEj8bOrdQkJQ264hdWQGtuf+QwzTQn
         AjY07sJDtAYQCFPXoUNeXGSG4io5GjAHiVUZEjJB3p+WbomUUazz84+cnfWMlL24nHgm
         NvTg==
X-Gm-Message-State: AOAM531PBHdj00FmgN6MGV0j+zNB1Vof5TDYblBluQNghPZYOaZc64x3
        /8XbzdSwFEDZ1J3dwgIxgPkdww==
X-Google-Smtp-Source: ABdhPJyzNgsOxAZkttvDEg6NKZQAJmyD7lHhDU9WO1jsRvLG6YbeZfbmTGx6t/c6mCbuwTbVVStT9Q==
X-Received: by 2002:a92:9e51:: with SMTP id q78mr12641146ili.268.1589725397996;
        Sun, 17 May 2020 07:23:17 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:6155:7c8c:3dc0:c56e])
        by smtp.gmail.com with ESMTPSA id g205sm2861748iof.21.2020.05.17.07.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 07:23:17 -0700 (PDT)
Date:   Sun, 17 May 2020 08:23:16 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200517142316.GA1996744@cisco>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 09:21:56PM +1000, Aleksa Sarai wrote:
> On 2020-05-17, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > Or... And that's more invasive but ultimately cleaner we v2 the whole
> > thing so e.g. SECCOMP_IOCTL_NOTIF_RECV2, SECCOMP_IOCTL_NOTIF_SEND2, and
> > embedd the size argument in the structs. Userspace sets the size
> > argument, we use get_user() to get the size first and then
> > copy_struct_from_user() to handle it cleanly based on that. A similar
> > model as with sched (has other unrelated quirks because they messed up
> > something too):
> > 
> > static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
> > {
> > 	u32 size;
> > 	int ret;
> > 
> > 	/* Zero the full structure, so that a short copy will be nice: */
> > 	memset(attr, 0, sizeof(*attr));
> > 
> > 	ret = get_user(size, &uattr->size);
> > 	if (ret)
> > 		return ret;
> > 
> > 	/* ABI compatibility quirk: */
> > 	if (!size)
> > 		size = SCHED_ATTR_SIZE_VER0;
> > 	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
> > 		goto err_size;
> > 
> > 	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
> > 	if (ret) {
> > 		if (ret == -E2BIG)
> > 			goto err_size;
> > 		return ret;
> > 	}
> > 
> > We're probably the biggest user of this right now and I'd be ok with
> > that change. If it's a v2 than whatever. :)
> 
> I'm :+1: on a new version and switch to copy_struct_from_user(). I was a
> little surprised when I found out that user_notif doesn't do it this
> way a while ago (and although in theory it is userspace's fault, ideally
> we could have an API that doesn't have built-in footguns).

But I thought the whole point was that we couldn't do that, because
there's two things that can vary in length (struct seccomp_notif and
struct seccomp_data)?

https://lore.kernel.org/lkml/CAGXu5j+ZPxu6egE1fEr+N9+zLx3N+SJ_vbS_zzj9_hrdWrrrWQ@mail.gmail.com/

Tycho
