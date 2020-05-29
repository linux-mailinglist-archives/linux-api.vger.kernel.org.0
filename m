Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF91E854B
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgE2Rkm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgE2Rkl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 13:40:41 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C11C08C5C8
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 10:40:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y17so3339522ilg.0
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQ3iFEKFTT0T49yh4ldw9sr179JaOXukpKkehgAJD9U=;
        b=C+K3vrF2R7sIGHajRN6wGA0vOi1wE/i5UrVTy17UMxKAFZpsLjFOGMHvOXkc+wMmoZ
         YJ3Mgn72jbaG3hJTHwLRMojjteM19g2Au2KaiMUBIM7bkV8b8hsT+UzDooXE1QdW51lX
         VCIKIzTR5AbqjIrhgcxmOWVlJKsZ5blp+SuxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQ3iFEKFTT0T49yh4ldw9sr179JaOXukpKkehgAJD9U=;
        b=caKTJ6QXWqcYJlsgnPzEfs8zQQuL/DbnktRL+4ueI6qTNsQKgOIOH36KkOTj/On+3S
         QNIk3LTNXxBSQyFPlzUDOU7wgtv0naYez/4mOw3OghVHd6XtQx1yjf2wdl30R73TDPk6
         ifsSSUbajqvAzFooEFMO26zgKksHY/IdihsdqkzxKAlyQjW9PugihuqB2mS3OayrU9MY
         c/RefidrV6VElN3QoK3jwufyeDFt6//Z+Yq/XYdwlbuFTt4hxCx/ObDu/JLOt2x7OyLw
         hKsrtKh3ls+buijAkTXR3C3iS/eTgKbClzxhNHAePkB6e0iI+LM6mgVM4cwuiL8adlvi
         clcA==
X-Gm-Message-State: AOAM530DQvLtN/rig5xHXpuYorH37mW6AJwLCEvc0dSzp+/hu7av5aFI
        3vIjjLIRzhQEevwiG1Z0L5KVRQ==
X-Google-Smtp-Source: ABdhPJxFSZ24wwe844nkQNKyzP7YEKKy8odi8DePlFNrsjYn235zGtMpiGwzJQs9rwbSEVXbICcURQ==
X-Received: by 2002:a92:8dd2:: with SMTP id w79mr8613220ill.239.1590774040468;
        Fri, 29 May 2020 10:40:40 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id 199sm5407708ilb.11.2020.05.29.10.40.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 10:40:39 -0700 (PDT)
Date:   Fri, 29 May 2020 17:40:38 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 1/3] seccomp: Add find_notification helper
Message-ID: <20200529174037.GA11153@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-2-sargun@sargun.me>
 <202005282319.2BA6AD88@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005282319.2BA6AD88@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> 
> While the comment is good, let's actually enforce this with:
> 
> if (WARN_ON(!mutex_is_locked(&filter->notif_lock)))
> 	return NULL;
> 
I don't see much use of lockdep in seccomp (well, any), but
wouldn't a stronger statement be to use lockdep, and just have:

lockdep_assert_held(&filter->notify_lock);

As that checks that the lock is held by the current task.
Although, that does put this check behind lockdep, which means
that running in "normal" circumstances is less safe (but faster?).
