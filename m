Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968EF140F66
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgAQQye (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 11:54:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45213 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQye (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 11:54:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so23253518qkl.12;
        Fri, 17 Jan 2020 08:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wgLl5grHs0gPcjfTsIGRVnNOC2uJ/o3JW7bJozvcUc=;
        b=T+tRTuaZ0E4ESs9z2xKryIf3Kf5XLx+XyRdcTVuDke7A68XHbQER3CLcDo/5Ucg31e
         8S/Oxaivpayz9mCUsCQFzlXOhwkAm6R8sXypTQQT8gAtG3Kzry42oAcwYu9Lr9Y2neEn
         GcshvuWX6e3CV+G//grZvCcyagz5LXRwE46t+9FxuivWnIsWepP9LL86yM1kL+T6ncPs
         qLpM4wXcK3Rb0BSIpKGZzqHQr9CbZJG+VqhDCaLYulslIiEGjQtwr5+rffgl8w7ZloG+
         zSxiMooKrsBwZ1JpHOD56l04Owa3BNusswKYsanrhrqPce6ffQ+lPnVAVZIFURIp+vGS
         hQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wgLl5grHs0gPcjfTsIGRVnNOC2uJ/o3JW7bJozvcUc=;
        b=OEZ8DQt/Jo/zh7iD0rsaENCDTvOzLQR6qPSYOzBSf5JjYriUkVHL6ZebxW6qbwSyp6
         Sge0SvbJglbd+oZD6n02vAjzDEx6HEduLcne7wGziXwGyOg76lyEErPbu5EhSNVdhP9W
         df2LpD3MtZTcEWMtgXXK+KxAqj8ZsLlluuV5le3r2gOoQjEgTjnNELuqgtv6V21z7uJc
         lYgaiaaymGEfwiPv8xjizyETsmidGxRAX8GXOqV/jy5gNIy8tTq1wekP/ip3VAXKb9sm
         SESFB1+0lHgwKz/ZzWfpi/BrQkOqlfH3WuRdGqUbSffxpruVeyCghhWmeYUc5BjATXRD
         7amQ==
X-Gm-Message-State: APjAAAXsmQ4JXRRUi4Rbc2divNirCmZFdYTY+g4UlK4ah5iOvlTFwCvL
        2hRLF1M6Qy7ZLhyke948VPY=
X-Google-Smtp-Source: APXvYqxpDvPwwGebd3YG7dAKQNK9IaKaCAYomHMrqtEwxnq4EA+sY368Jto26N5fBZJ5xVP6V+uZbw==
X-Received: by 2002:a37:b601:: with SMTP id g1mr39654001qkf.114.1579280072984;
        Fri, 17 Jan 2020 08:54:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:7d10])
        by smtp.gmail.com with ESMTPSA id q131sm12128682qke.1.2020.01.17.08.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:54:32 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:54:31 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 0/5] clone3 & cgroups: allow spawning processes into
 cgroups
Message-ID: <20200117165431.GI2677547@devbig004.ftw2.facebook.com>
References: <20200117002143.15559-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117002143.15559-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey, imma wait for v4 w/ the perm check fixed.

Thanks.

-- 
tejun
