Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5F1D6882
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 17:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEQPCS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQPCR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 11:02:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20B2C05BD09
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 08:02:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so7328589ile.9
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qfGQru1DQ7dhkCFJk1ko3cW7sBpUltkWhzAfvUqe2DI=;
        b=S9FT77W3xRwy8bthBnonelSGFRbLLRr9pn0lRgc1aSkv46DpI3gf7LfrlD65NIi4OR
         q8s3XDTbjL9kMl4JWpwnj3eBd2SCbQKZR7GIkomjucnuCvqRAToM8aPj1L5hCPdpNa+U
         qkCk+tr6w5icMS2X+S65yh/oxsOCHqrRZiJb1Bu2bz5z722jMUxRutTQraOoe1/40EGc
         Hc8ZdyNhOxKp+xjDqRpaUcprPnYOw6XEOtudSuy8qFp8opTzZQEXJ65vmRfy3m3o19vn
         fG7LP9179cdFmNKVsLEYc/3l1ic+AH/ipaxStjOFM+VrT9HXSKeM42GTYYZJL3CNBWBs
         BsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qfGQru1DQ7dhkCFJk1ko3cW7sBpUltkWhzAfvUqe2DI=;
        b=NNwvBY/Cx5P7BaVi2A2vxR6pLDY401nx+BRznGHqKQnaKm9bQfAyvD9rXGqy0DLJ9d
         AocmmhFS7ovfejE3hXtrkayxDtAE0AYQsYcBWIQvsyrS8TDYwruyg14mIiG1B8hQyAvN
         ITOteqTa4yYXzzUwETiZ+vvQmD+JIx6RGoN1NJ1+zR7rSNDTg/QlMEyYYtl/fthLiUWp
         VHdAIMA04scMvUxK9I/CxNj30v3cF/GL/aIYDf5D7KVrZVAkxYamxdOOrAIM6/UqsGwI
         33IqovqO5hzoMyKTfUtb9dBJsVfEsho1rqpkN9gZ5kYXFnP6VniDuQ00cMCuQ33Z3OmK
         eE1Q==
X-Gm-Message-State: AOAM531SA5IEV97TtPEKlV2Q/1BAFu4ckgSUlalU+Mi0Jf0tBxPbvV81
        7fvx13cTD/ewIBAGWNiXpXyzI/ZfX6g=
X-Google-Smtp-Source: ABdhPJzikVveOD4S1XQewT9omGCsdCBEnHet0SfjPhOw6Ylol0GuiR99q2n7cdDHqo9cXkWZIsJz0w==
X-Received: by 2002:a92:c211:: with SMTP id j17mr12489801ilo.85.1589727737033;
        Sun, 17 May 2020 08:02:17 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:6155:7c8c:3dc0:c56e])
        by smtp.gmail.com with ESMTPSA id s5sm2930758iop.4.2020.05.17.08.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:02:16 -0700 (PDT)
Date:   Sun, 17 May 2020 09:02:15 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <asarai@suse.de>, Kees Cook <keescook@chromium.org>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200517150215.GE1996744@cisco>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517144603.GD1996744@cisco>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 08:46:03AM -0600, Tycho Andersen wrote:
> On Sun, May 17, 2020 at 04:33:11PM +0200, Christian Brauner wrote:
> > struct seccomp_notif2 {
> > 	__u32 notif_size;
> > 	__u64 id;
> > 	__u32 pid;
> > 	__u32 flags;
> > 	struct seccomp_data data;
> > 	__u32 data_size;
> > };
> 
> I guess you need to put data_size before data, otherwise old userspace
> with a smaller struct seccomp_data will look in the wrong place.
> 
> But yes, that'll work if you put two sizes in, which is probably
> reasonable since we're talking about two structs.

Well, no, it doesn't either. Suppose we add a new field first to
struct seccomp_notif2:

struct seccomp_notif2 {
    __u32 notif_size;
    __u64 id;
    __u32 pid;
    __u32 flags;
    struct seccomp_data data;
    __u32 data_size;
    __u32 new_field;
};

And next we add a new field to struct secccomp_data. When a userspace
compiled with just the new seccomp_notif2 field does:

seccomp_notif2.new_field = ...;

the compiler will put it in the wrong place for the kernel with the
new seccomp_data field too.

Sort of feels like we should do:

struct seccomp_notif2 {
    struct seccomp_notif *notif;
    struct seccomp_data *data;
};

?

Tycho
