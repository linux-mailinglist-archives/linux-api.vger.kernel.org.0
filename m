Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFA38C30C
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhEUJ3b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhEUJ3X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 05:29:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2B0C0613ED
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 02:27:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so7012011pjp.4
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YcLZ8e3MbA7u7iz+gM84yYIhhW/9rebbjr6JcO2AJnA=;
        b=VY0bZl+dQIHuJ3VDs1EkSw5KObGGdc6T0vNdiE3pAdKUJtVyJ+F5vIy+3jlHWJ8VCp
         R/Is13j63P+FXXdBqlGfHXvdhILzzFg2J2jh/egvLPUO278qTb+zA44AppOpy54FxTnV
         SZ4Vp+EFlrfK7fVBH1X0E1wwSg/2Bqw1bVfHLt89Z6OCsZ4WmPrCQre94f2d2+WIahHH
         LXKI+1CHsjxP0M/gFm/Q1ZyJ7/+LwHGMBlH0LBDxeenU7F0eUGaarF3eRNWYCOXo78gl
         Dhs9AEAw3MY3PjIbiDcTIRgq784HUYiBgOWBEpm8ouCPiU1YeNqP2f6xbhP06PZCZIqe
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcLZ8e3MbA7u7iz+gM84yYIhhW/9rebbjr6JcO2AJnA=;
        b=nA+/TnkISoYTY0MGfhiU7u1jknDp4CHTty8ipo+fjJbZ3BC8+7/5HAfY8gcIAKk+dI
         +6+Xg1ux/P2nfDG4Oy6Xc5V64melf0Vjcg7eoRuVQtX968Uv1IYoYkwr9TxSllmLoW8O
         9uSO9l9/oMejlaS/EfpRp8XdVsFoJmLzn6T7Iv8uJJ4RVKYj87rGPUjaVMywAO9gZsq1
         kdKBEPyOMu3SHDcB9JWmV3NNmx2XSQ0ZYK3HlNFDnWsgc7Qk86uyNyAtQJmtaiDenbvF
         lU/ZqEsfqEX7M9lJAg7/gcqxVLHNPDC4JUwWM02Vvz/cDJ4cEjZT17jk1qGsKSBcYdLz
         lVuA==
X-Gm-Message-State: AOAM530uPkSsDfdES9EwZTHOwipsKHCipB1wKLP2rwznj0po1DTtdSt/
        6/osgiVPzNtMLh4UGJ2haNbeaw==
X-Google-Smtp-Source: ABdhPJxcto2Xjz9wGX7cRgqbAPaN3E4FHGFnPienYZqIYptyiiU/nM9Hyno3/bxj3/RxgqG+T0RRyQ==
X-Received: by 2002:a17:90a:b388:: with SMTP id e8mr10003228pjr.167.1621589224321;
        Fri, 21 May 2021 02:27:04 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:42b2:c084:8468:626a])
        by smtp.gmail.com with ESMTPSA id x9sm3925421pfd.66.2021.05.21.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 02:27:03 -0700 (PDT)
Date:   Fri, 21 May 2021 19:26:50 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying function
Message-ID: <YKd82mgLHaWehNID@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <24c761bd0bd1618c911a392d0c310c24da7d8941.1621473846.git.repnop@google.com>
 <CAOQ4uxjK-0nC5OHGQ5ArDuNq_3pFKfyjBmUfCqv=kAsq5y8KUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjK-0nC5OHGQ5ArDuNq_3pFKfyjBmUfCqv=kAsq5y8KUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 04:59:23PM +0300, Amir Goldstein wrote:
> On Thu, May 20, 2021 at 5:11 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > The copy_info_to_user() function has been repurposed with the idea to
> 
> Sorry I gave comment on patch 5 before I knew you repurposed
> copy_info_to_user().
> Perhaps it would be better to give a non ambiguous name like
> copy_info_records_to_user() or

^ I like this.

> copy_fid_info_records_to_user() and leave pidfd out of this helper.
> If you do wish to keep pidfd copy inside this helper and follow my
> suggestion on patch 5 you will have to pass in pidfd as another argument.

I'd like to keep all the info record related copying branching out
from a single helper, which in this case will now be
copy_info_records_to_user().

/M
