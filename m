Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFD1E75DA
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE2GXg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 02:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2GXf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 02:23:35 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24FC03E969
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 23:23:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p30so899276pgl.11
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLlzkiwXyPhTxGzF5jit/MYyFaQFHEK70UOxhdZtI5c=;
        b=Z+miJH9wcmdbU95F6BDxKYteYwdab0eN8L8nETOEWCZVZZkW/rEUMocD7CBb32c701
         +tvtXMfOsTo334hqVXhONy+LvqQVhhTXZsO687J+Q9ZN5YA/JpPBLheEW1OiKccEOBAm
         vPkQd9q4H4UVJRPmuBCp1vYnRBwFiVgn0mC/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLlzkiwXyPhTxGzF5jit/MYyFaQFHEK70UOxhdZtI5c=;
        b=sSYxGf+LJ/MjxfN1NykxBS6Ez4bIRIWrvGOTgNMywex5ke0wyp/qfEqeOBR6a4TJJs
         fT+2JHmXZH33Qzpn1ABYIeck/f2y9ljNYtEatiZ3SRBRtPpI38yjviJI+qqdvaP3svyk
         +OWBTdRSjM5CwPrHXcIO5aGaRfv2zdHX+p5//86gF0sFv+K8GEPnuWTHyqfToeHRONpI
         iN1LWyNZYs3r+e0Ojft6+NHq8wc8u+WcxaPM1hLfoyne5CN5yo5b1kE5hntlATZbA2e9
         ZCXDpxYy0J0RCofD1qAcdchTxnSVnOS4qYkQ19Gc+k54avDk+NJkg4yWZS2ckydHCZE3
         rakg==
X-Gm-Message-State: AOAM530WBG59xBs87E7x+QZWgu62wDraw3Sx/m7VkZsj7l6qkD5hQ6JQ
        uxoHJXsPHt4+MX62incAeLrgaQ==
X-Google-Smtp-Source: ABdhPJx7hx0BKE+0tLY98OeGHN8BEprTrTD5qAT85KRoeW5vEds5FygRJwT2U9PekEsHVcc4bUQooQ==
X-Received: by 2002:a63:ff07:: with SMTP id k7mr6136004pgi.449.1590733414728;
        Thu, 28 May 2020 23:23:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67sm6415128pfg.9.2020.05.28.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 23:23:33 -0700 (PDT)
Date:   Thu, 28 May 2020 23:23:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 1/3] seccomp: Add find_notification helper
Message-ID: <202005282319.2BA6AD88@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110858.3265-2-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 28, 2020 at 04:08:56AM -0700, Sargun Dhillon wrote:
> This adds a helper which can iterate through a seccomp_filter to
> find a notification matching an ID. It removes several replicated
> chunks of code.

Nice, yes. I was noticing this redundancy too while I was looking at
notify locking earlier today. One note below...

> +/* must be called with notif_lock held */
> +static inline struct seccomp_knotif *
> +find_notification(struct seccomp_filter *filter, u64 id)
> +{
> +	struct seccomp_knotif *cur;

While the comment is good, let's actually enforce this with:

if (WARN_ON(!mutex_is_locked(&filter->notif_lock)))
	return NULL;

> +
> +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> +		if (cur->id == id)
> +			return cur;
> +	}
> +
> +	return NULL;
> +}

Everything else looks good!

-- 
Kees Cook
