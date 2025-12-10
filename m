Return-Path: <linux-api+bounces-5533-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48BCB3039
	for <lists+linux-api@lfdr.de>; Wed, 10 Dec 2025 14:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAB03020368
	for <lists+linux-api@lfdr.de>; Wed, 10 Dec 2025 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3132470E;
	Wed, 10 Dec 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IOLK7/8N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+cpyhqn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xYz6leo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T94VqHhR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519125F98B
	for <linux-api@vger.kernel.org>; Wed, 10 Dec 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373171; cv=none; b=WFTcksv1ZAnblGw9Q9as/8e8G6YhAYlgFISqSIp0lT/EhS5GGFIn/3VDcn4F0tL3JLKHfA7RzcFQ1MConaQB+64eNg4HV9DcWceJGDWMKYVDdPqUh5/0ZHoxwfOasNg0cET408XLgKEW9Xv+trPF05f02+xCrTUtcFG8ThYj4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373171; c=relaxed/simple;
	bh=NtUfQHVhP76BOINqlqigBc5JZM6OKLdCKFLIaCDK4t4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0DLcE69vJrra/kXnWf4uLHevSVeZY+OO9eY29Ey3MIwNEb6tarV3nbtXcP5gea9Fsu8PWsN3/edQzqlPkj20UxH/1PQfMy/5gdavdKccAyS4V4YdUyOOXx8AkrcF4UZ6uTYDIp5qIRBT/tMtrVspSGWRFsq6ymBSuLEv5egl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IOLK7/8N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+cpyhqn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xYz6leo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T94VqHhR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1F4C3388E;
	Wed, 10 Dec 2025 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765373168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sqEwaJiuTTEdJYRyFNYyvoSQ8kH6V2bwjSa91iDg2o=;
	b=IOLK7/8NBC0KHcb7BkW6LGEcNTz4z2DQ3eeGPvVYZBbkKAPlX4vssejPu6vSiQpj3OqfOc
	bSl2OWTQ6gFROF6eLSwW/komBZqftq+6bsjLHIRIlsU6sBKnwHz93DhlweuvYHHOh0EW+4
	xd3yoFbOpDTlhyQQtFz8QBC1e+MZIHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765373168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sqEwaJiuTTEdJYRyFNYyvoSQ8kH6V2bwjSa91iDg2o=;
	b=p+cpyhqnYdNU5N5EvqGB+UR/w+LcWfbnSgqg4K1fKA8xkGar3HOms/uvjql5M7KTnm6aL9
	501EykxVHTkFW7DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xYz6leo8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T94VqHhR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765373166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sqEwaJiuTTEdJYRyFNYyvoSQ8kH6V2bwjSa91iDg2o=;
	b=xYz6leo8CAX2ppelOArAC10hFdiHqi6Bu3Ms0XAlmi6RlEV500NbHFc1hV5ylCtCCjVbkH
	PN0lDXsHZFy10Dqx8yiSC0EB86j3SQz3mQMXeDQR9i38JYFD3lquhmgxj1tJtAabBV+X00
	dR0jUyS1RKFn1oKsE02fyXGMyl55CuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765373166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sqEwaJiuTTEdJYRyFNYyvoSQ8kH6V2bwjSa91iDg2o=;
	b=T94VqHhRjNnZlV21IA7AmiQ8LhgI7EY5XkOV6f1n1UQ7m7jL/IGo3J84qGyDcqeZP69LZV
	/CUQDfqoUpJ/MSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 741BD3EA63;
	Wed, 10 Dec 2025 13:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id veIWG+50OWnmLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 10 Dec 2025 13:26:06 +0000
Date: Wed, 10 Dec 2025 14:26:06 +0100
Message-ID: <87v7iecvtd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Victor Krawiec <victor.krawiec@arturia.com>
Cc: gregkh@linuxfoundation.org,
	tiwai@suse.de,
	corbet@lwn.net,
	jilliandonahue58@gmail.com,
	selvarasu.g@samsung.com,
	jkeeping@inmusicbrands.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_midi: allow customizing the USB MIDI interface string through configfs
In-Reply-To: <20251209164006.143219-1-victor.krawiec@arturia.com>
References: <20251209164006.143219-1-victor.krawiec@arturia.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: C1F4C3388E
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.de,lwn.net,gmail.com,samsung.com,inmusicbrands.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Tue, 09 Dec 2025 17:40:06 +0100,
Victor Krawiec wrote:
> 
> When using f_midi from configfs the USB MIDI interface string is hardcoded
> to 'MIDI function'.
> 
> This USB string descriptor is used by some third-party OS or software to
> display the name of the MIDI device
> 
> Since we add an additional string option a new macro block was created to
> factorize declarations
> 
> Signed-off-by: Victor Krawiec <victor.krawiec@arturia.com>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> ---
> V1 -> V2:
> 	- Add documentation
> 	- Cleanup unnecessary *_allocated boolean as requested in review
> 
>  .../ABI/testing/configfs-usb-gadget-midi      |  17 +--
>  Documentation/usb/gadget-testing.rst          |  17 +--
>  drivers/usb/gadget/function/f_midi.c          | 110 ++++++++++--------
>  drivers/usb/gadget/function/u_midi.h          |   2 +-
>  4 files changed, 78 insertions(+), 68 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-midi b/Documentation/ABI/testing/configfs-usb-gadget-midi
> index 07389cddd51a..d6bd67bb91fc 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-midi
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-midi
> @@ -4,11 +4,12 @@ KernelVersion:	3.19
>  Description:
>  		The attributes:
>  
> -		==========	====================================
> -		index		index value for the USB MIDI adapter
> -		id		ID string for the USB MIDI adapter
> -		buflen		MIDI buffer length
> -		qlen		USB read request queue length
> -		in_ports	number of MIDI input ports
> -		out_ports	number of MIDI output ports
> -		==========	====================================
> +		================	====================================
> +		index			index value for the USB MIDI adapter
> +		id			ID string for the USB MIDI adapter
> +		buflen			MIDI buffer length
> +		qlen			USB read request queue length
> +		in_ports		number of MIDI input ports
> +		out_ports		number of MIDI output ports
> +		interface_string	USB AudioControl interface string
> +		================	====================================
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index 5f90af1fb573..01a128d664cb 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -368,14 +368,15 @@ Function-specific configfs interface
>  The function name to use when creating the function directory is "midi".
>  The MIDI function provides these attributes in its function directory:
>  
> -	=============== ====================================
> -	buflen		MIDI buffer length
> -	id		ID string for the USB MIDI adapter
> -	in_ports	number of MIDI input ports
> -	index		index value for the USB MIDI adapter
> -	out_ports	number of MIDI output ports
> -	qlen		USB read request queue length
> -	=============== ====================================
> +	================ ====================================
> +	buflen		 MIDI buffer length
> +	id		 ID string for the USB MIDI adapter
> +	in_ports	 number of MIDI input ports
> +	index		 index value for the USB MIDI adapter
> +	out_ports	 number of MIDI output ports
> +	qlen		 USB read request queue length
> +	interface_string USB AudioControl interface string
> +	================ ====================================
>  
>  Testing the MIDI function
>  -------------------------
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index da82598fcef8..ad679a6ecac1 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -875,6 +875,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  	struct usb_composite_dev *cdev = c->cdev;
>  	struct f_midi *midi = func_to_midi(f);
>  	struct usb_string *us;
> +	struct f_midi_opts *opts;
>  	int status, n, jack = 1, i = 0, endpoint_descriptor_index = 0;
>  
>  	midi->gadget = cdev->gadget;
> @@ -883,6 +884,10 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  	if (status < 0)
>  		goto fail_register;
>  
> +	opts = container_of(f->fi, struct f_midi_opts, func_inst);
> +	if (opts->interface_string)
> +		midi_string_defs[STRING_FUNC_IDX].s = opts->interface_string;
> +
>  	/* maybe allocate device-global string ID */
>  	us = usb_gstrings_attach(c->cdev, midi_strings,
>  				 ARRAY_SIZE(midi_string_defs));
> @@ -1178,59 +1183,60 @@ end:									\
>  									\
>  CONFIGFS_ATTR(f_midi_opts_, name);
>  
> +#define F_MIDI_OPT_STRING(name)						\
> +static ssize_t f_midi_opts_##name##_show(struct config_item *item, char *page) \
> +{									\
> +	struct f_midi_opts *opts = to_f_midi_opts(item);		\
> +	ssize_t result;							\
> +									\
> +	mutex_lock(&opts->lock);					\
> +	if (opts->name) {						\
> +		result = strscpy(page, opts->name, PAGE_SIZE);		\
> +	} else {							\
> +		page[0] = 0;						\
> +		result = 0;						\
> +	}								\
> +									\
> +	mutex_unlock(&opts->lock);					\
> +									\
> +	return result;							\
> +}									\
> +									\
> +static ssize_t f_midi_opts_##name##_store(struct config_item *item,	\
> +					 const char *page, size_t len)	\
> +{									\
> +	struct f_midi_opts *opts = to_f_midi_opts(item);		\
> +	int ret;							\
> +	char *c;							\
> +									\
> +	mutex_lock(&opts->lock);					\
> +	if (opts->refcnt > 1) {						\
> +		ret = -EBUSY;						\
> +		goto end;						\
> +	}								\
> +									\
> +	c = kstrndup(page, len, GFP_KERNEL);				\
> +	if (!c) {							\
> +		ret = -ENOMEM;						\
> +		goto end;						\
> +	}								\
> +	kfree(opts->name);						\
> +	opts->name = c;							\
> +	ret = len;							\
> +end:									\
> +	mutex_unlock(&opts->lock);					\
> +	return ret;							\
> +}									\
> +									\
> +CONFIGFS_ATTR(f_midi_opts_, name)
> +
>  F_MIDI_OPT_SIGNED(index, true, SNDRV_CARDS);
>  F_MIDI_OPT(buflen, false, 0);
>  F_MIDI_OPT(qlen, false, 0);
>  F_MIDI_OPT(in_ports, true, MAX_PORTS);
>  F_MIDI_OPT(out_ports, true, MAX_PORTS);
> -
> -static ssize_t f_midi_opts_id_show(struct config_item *item, char *page)
> -{
> -	struct f_midi_opts *opts = to_f_midi_opts(item);
> -	ssize_t result;
> -
> -	mutex_lock(&opts->lock);
> -	if (opts->id) {
> -		result = strscpy(page, opts->id, PAGE_SIZE);
> -	} else {
> -		page[0] = 0;
> -		result = 0;
> -	}
> -
> -	mutex_unlock(&opts->lock);
> -
> -	return result;
> -}
> -
> -static ssize_t f_midi_opts_id_store(struct config_item *item,
> -				    const char *page, size_t len)
> -{
> -	struct f_midi_opts *opts = to_f_midi_opts(item);
> -	int ret;
> -	char *c;
> -
> -	mutex_lock(&opts->lock);
> -	if (opts->refcnt > 1) {
> -		ret = -EBUSY;
> -		goto end;
> -	}
> -
> -	c = kstrndup(page, len, GFP_KERNEL);
> -	if (!c) {
> -		ret = -ENOMEM;
> -		goto end;
> -	}
> -	if (opts->id_allocated)
> -		kfree(opts->id);
> -	opts->id = c;
> -	opts->id_allocated = true;
> -	ret = len;
> -end:
> -	mutex_unlock(&opts->lock);
> -	return ret;
> -}
> -
> -CONFIGFS_ATTR(f_midi_opts_, id);
> +F_MIDI_OPT_STRING(id);
> +F_MIDI_OPT_STRING(interface_string);
>  
>  static struct configfs_attribute *midi_attrs[] = {
>  	&f_midi_opts_attr_index,
> @@ -1239,6 +1245,7 @@ static struct configfs_attribute *midi_attrs[] = {
>  	&f_midi_opts_attr_in_ports,
>  	&f_midi_opts_attr_out_ports,
>  	&f_midi_opts_attr_id,
> +	&f_midi_opts_attr_interface_string,
>  	NULL,
>  };
>  
> @@ -1262,8 +1269,8 @@ static void f_midi_free_inst(struct usb_function_instance *f)
>  	mutex_unlock(&opts->lock);
>  
>  	if (free) {
> -		if (opts->id_allocated)
> -			kfree(opts->id);
> +		kfree(opts->id);
> +		kfree(opts->interface_string);
>  		kfree(opts);
>  	}
>  }
> @@ -1279,7 +1286,8 @@ static struct usb_function_instance *f_midi_alloc_inst(void)
>  	mutex_init(&opts->lock);
>  	opts->func_inst.free_func_inst = f_midi_free_inst;
>  	opts->index = SNDRV_DEFAULT_IDX1;
> -	opts->id = SNDRV_DEFAULT_STR1;
> +	opts->id = NULL;
> +	opts->interface_string = NULL;
>  	opts->buflen = 512;
>  	opts->qlen = 32;
>  	opts->in_ports = 1;
> diff --git a/drivers/usb/gadget/function/u_midi.h b/drivers/usb/gadget/function/u_midi.h
> index 2e400b495cb8..41cb8aa73f09 100644
> --- a/drivers/usb/gadget/function/u_midi.h
> +++ b/drivers/usb/gadget/function/u_midi.h
> @@ -19,7 +19,7 @@ struct f_midi_opts {
>  	struct usb_function_instance	func_inst;
>  	int				index;
>  	char				*id;
> -	bool				id_allocated;
> +	char				*interface_string;
>  	unsigned int			in_ports;
>  	unsigned int			out_ports;
>  	unsigned int			buflen;
> 
> base-commit: 67a454e6b1c604555c04501c77b7fedc5d98a779
> -- 
> 2.43.0
> 

