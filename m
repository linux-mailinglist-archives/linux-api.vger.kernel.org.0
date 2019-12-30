Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EA012D366
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfL3S37 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 13:29:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40311 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfL3S37 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 13:29:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so39466512otj.7
        for <linux-api@vger.kernel.org>; Mon, 30 Dec 2019 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zfxgfsqm1SJE4TcJmYRwd0qOITSW8/a6fexRTjW5qIA=;
        b=n4SWnhu/BznKX8qVa8EVmGkKn7yo9GEeI8hzW1AoM4LbRJ9fqWrWsUAXA7igDJALtc
         1DQMqYL+U4ynftk3nwB1VgDbUBfcLgLsL53dif8B94TG4L1+y7woRTR6y5mnR5IMlMNj
         ww5OiPYJaet6qx5sFxwJJG2fiQcvJOLhAQ8LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zfxgfsqm1SJE4TcJmYRwd0qOITSW8/a6fexRTjW5qIA=;
        b=TfsnAxpJMDSZiwdpT6KfhMos5XCr/QmO0dJWGWFSKMYHPI6/nNGIfMeuzdyX3pjQf7
         Yhna8emdYi7l+72/n5I0oVig93E5e5uSyxwAsBtM+KhR/4dW/m22biNlb5pNxfd8v/Sl
         96ux7HVL4iZu4ZEiJKcQgWpI61EmizrKg13BmGHwOCOpTc6yrAZKM0oNPmP2tOICm71a
         urFQ0EqIjvBSju1oQTQcxcbJ3V+5VFBfzoRjEyGl3EdYTQC87vf5OGrAw+IWgLHA+BO3
         qRBpqXXK0GJLxBHdxgB8yHBnrZH6ek8yz7uJ5suO9xhLiJk0kjCwpfqWcnANlEnpxx6V
         pLfA==
X-Gm-Message-State: APjAAAU4CiGJwgj9WiusZVGnNOqEgvqehDciEkzVdsER/F+u7PO1L1yr
        WKv+xyAg9zkrsb1VzEcbMeBSDA==
X-Google-Smtp-Source: APXvYqxhKs3RF28JdXdrd1kkJLiQz7ewiOWTRKqumqPgpFOFYzu9ZLQBdr5vMThF5m3/AI+NAIVidw==
X-Received: by 2002:a05:6830:1cc5:: with SMTP id p5mr51090774otg.218.1577730598657;
        Mon, 30 Dec 2019 10:29:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p16sm15957208otq.79.2019.12.30.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:29:57 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:29:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 2/3] seccomp: Check that seccomp_notif is zeroed out
 by the user
Message-ID: <201912301029.E9739655@keescook>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229062451.9467-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229062451.9467-2-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 10:24:50PM -0800, Sargun Dhillon wrote:
> This patch is a small change in enforcement of the uapi for
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
> is passed (seccomp_notif) must be zeroed out. Previously any of its
> members could be set to nonsense values, and we would ignore it.
> 
> This ensures all fields are set to their zero value.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> Acked-by: Tycho Andersen <tycho@tycho.ws>

Applied!

-- 
Kees Cook
