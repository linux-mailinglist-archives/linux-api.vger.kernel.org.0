Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3812F83839
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2019 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHFRvB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Aug 2019 13:51:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34573 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbfHFRvA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Aug 2019 13:51:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so41904536pfo.1
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2019 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2EETmRt9EOQBbfhEIb5t8mf9LVzodqT5JEXYRBL8vQs=;
        b=QRDCdElFaPyPLEkU6mKIuaw9r9hA6R9E1UgdMFkhvIow1uFsx15Hp7vXPoTETEsexl
         6Gu7cM0C7sYqiwR3/yCTW4Jf7dp/0Eq82n3Uh9i7+TL9tA3NtG709ffpdC9ozrmH1whR
         W26T1AIHLYKpwEkkbKkzlwo4msUA1SJMcl+wspZv/gHsQap3qPh1gC/MyvMTOv8UTI30
         0uXHG/dJyIvWlmIjfD4OwzrSTWSDH6PH7yIhfxURftS4k745t/38kWutkxl9dYVlpHg+
         ReDTsneBOh5h+iejRB0/tT9GTrISZoOzBWKW57/SFUOoqxI/ZPGEldfoiznDgSO70+LV
         T0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2EETmRt9EOQBbfhEIb5t8mf9LVzodqT5JEXYRBL8vQs=;
        b=KZXs84ucecifIYtwsSP4tWrpWAlYWC1jsA7Pe/wK+i9pXTADBhAD9N8s523mLDUZaE
         HXQkecEmkfJpgVogEjRaVtPzpri+319VlAwcuscZ9UTvmSko1bQVtGtAupm9zpbb8c6+
         jP4FynTZhGddkqznw8W4CUzulhe6Y5VEtq2O8Spb2ECWm2e7bYTE1CaYtwU8yXQHguF0
         j22vnS1RHlufTob0kp0R7YSuFgdfxOxE+90ex0Qi1o9+70EjzsZtlnQqW+rP9M9Dr/nm
         gJyTpaXV9QEqM0V1iBEhBbiY3qtNGNieZYcXal66xpc0XVTphwv/v4NpE1tIK1Xuq6aB
         3YPg==
X-Gm-Message-State: APjAAAUy5s5HswYohzsoRhxj6iWoRTgajF8FJWRVCBXwVpzhRbEeUz5b
        gsYPfL0tZ8xiPKLNt5EOi3L7LQ==
X-Google-Smtp-Source: APXvYqzq2kp3YRopoRLloI6d6xMJCf6nH8yiSo18UYl4X0l0Jv6xYG7hv6ysNLGHZSOp1xIn2UIu5A==
X-Received: by 2002:a17:90a:28e4:: with SMTP id f91mr4238337pjd.99.1565113859962;
        Tue, 06 Aug 2019 10:50:59 -0700 (PDT)
Received: from brauner.io (c-67-180-61-213.hsd1.ca.comcast.net. [67.180.61.213])
        by smtp.gmail.com with ESMTPSA id f7sm85627592pfd.43.2019.08.06.10.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:50:59 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Tue, 6 Aug 2019 19:50:56 +0200
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/2] tests: move common definitions and functions into
 pidfd.h
Message-ID: <20190806175055.pazfyeyhbdbmuh6l@brauner.io>
References: <20190726162226.252750-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190726162226.252750-1-surenb@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 09:22:25AM -0700, Suren Baghdasaryan wrote:
> Move definitions and functions used across different pidfd tests into
> pidfd.h header.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Christian Brauner <christian@brauner.io>

Applied-to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd

Tracked-in:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next
